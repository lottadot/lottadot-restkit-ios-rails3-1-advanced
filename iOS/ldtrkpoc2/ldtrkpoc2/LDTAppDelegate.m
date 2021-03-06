//
//  LDTAppDelegate.m
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/8/11.
//  Copyright (c) 2011 Lottadot LLC. All rights reserved.
//

#import "LDTAppDelegate.h"
#import "MyModelEntities.h"
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>

@interface LDTAppDelegate (Private)
- (void)setupRestKit;
@end;

@implementation LDTAppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self setupRestKit];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Restkit Stack

/* 
 Setup Restkit with debug-logging to the console so we can see what's going on 
 */

- (void)setupRestKit {   
    RKClient *client = [RKClient clientWithBaseURL:LDTHOSTNAME];
    NSLog(@"Configured RestKit Client: %@", client);
    
    // See RKLog.h for more info on using the logging system to debug.    
    RKLogConfigureByName("RestKit", RKLogLevelTrace); 
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace); 
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace); 
    RKLogConfigureByName("RestKit/Network/Queue", RKLogLevelTrace); 
    
    // Enable automatic network activity indicator management
    client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    
    //Setup Restkit Mappings
    RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:LDTHOSTNAME];
    
    // Enable automatic network activity indicator management
    objectManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    
    objectManager.acceptMIMEType = RKMIMETypeJSON; 
    objectManager.serializationMIMEType = RKMIMETypeJSON;
    
    
    /*
     We want to initialize RestKit with a Core Data Managed Object Store, backed by a SQLLite file. 
     If we provide a seed database, we can pass that in as well.
     RestKit's objectStoreWithStoreFilename will take care of creating, seeding, and merging from 
     main bundle for you.
     
     Note that objectStoreWithStoreFilename will end using initWithStoreFilename which will 
     retain the Moc.
     */
    
    NSString *seedDatabaseName = nil;
    NSString *databaseName = @"ldtrkpoc2.sqlite";
    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:databaseName 
                                                             usingSeedDatabaseName:seedDatabaseName 
                                                                managedObjectModel:nil 
                                                                          delegate:self];
    
#pragma mark - Reskit Mappings
    
    //RKManagedObjectMapping	*topicMapping	= [RKObjectMapping mappingForClass:[Topic class]];
    RKManagedObjectMapping	*topicMapping	= [RKManagedObjectMapping mappingForEntityWithName:@"Topic"];
    RKManagedObjectMapping	*postMapping	= [RKManagedObjectMapping mappingForEntityWithName:@"Post"];
    RKManagedObjectMapping	*authorMapping	= [RKManagedObjectMapping mappingForEntityWithName:@"Author"];
    
#pragma mark - Restkit Topic Setup  
    
    [topicMapping mapKeyPathsToAttributes:@"id", @"topicID",
     @"title", @"title",
     @"body", @"body",
     nil];
    [topicMapping setPrimaryKeyAttribute:@"topicID"];
    //topicMapping.primaryKeyAttribute = @"topicID";
    [topicMapping mapRelationship:@"topic" withMapping:topicMapping];
    [topicMapping mapRelationship:@"post" withMapping:postMapping];
    
    //TODO: evaluate declaring the relationships like this
    // [albumMapping mapKeyPath:@"presentations" toRelationship:@"presentations" withMapping:presentationMapping];
    // so we might try
    // [topicMapping mapKeyPath:@"posts" toRelationship:@"posts" withMapping:postMapping];
    // [postMapping mapKeyPath:@"author" toRelationship:@"author" withMapping:authorMapping];
    
    // On a Topic the forKeyPath must be @"" rather then @"/topics"
    [objectManager.mappingProvider setMapping:topicMapping forKeyPath:@"/topics"];
    
    // Configure the Serialization mapping for a Widget. Without this a PostObject will fail
    // This post was helpful: https://groups.google.com/group/restkit/browse_frm/thread/959b6e30c86d257f/e0bc0a37b46c18a5?lnk=gst&q=You+must+provide+a+serialization+mapping+for+objects+of+type#e0bc0a37b46c18a5
    RKObjectMapping *topicSerializationMapping = [RKObjectMapping 
                                                   mappingForClass:[Topic class]]; 
    [topicSerializationMapping mapKeyPath:@"topicID" 
                               toAttribute:@"id"]; 
    [topicSerializationMapping mapKeyPath:@"title" 
                               toAttribute:@"title"]; 
    [topicSerializationMapping mapKeyPath:@"body" 
                               toAttribute:@"body"]; 
    
    [objectManager.mappingProvider 
     setSerializationMapping:topicSerializationMapping forClass:[Topic class]];

    // Configure a default resource path for Topics. 
    // Will send GET, PUT, and DELETE requests to '/topics/XXXX'
    // topicID is a property on the Topic class
    [objectManager.router routeClass:[Topic class] toResourcePath:@"/topics/:topicID"];
    
    // Send POST requests for instances of Topic to '/topics'
    [objectManager.router routeClass:[Topic class] toResourcePath:@"/topics" forMethod:RKRequestMethodPOST];
	[objectManager.router routeClass:[Topic class] toResourcePath:@"/topics/(topicID)" forMethod:RKRequestMethodPUT];
	[objectManager.router routeClass:[Topic class] toResourcePath:@"/topics/(topicID)" forMethod:RKRequestMethodDELETE];
    
#pragma mark - Reskit Post Model Setup
    
    [postMapping mapKeyPathsToAttributes:@"id", @"postID",
     @"title", @"title",
     @"body", @"body",
     @"topic_id", @"topicID",
     @"author_id", @"authorID",
     nil];
    postMapping.primaryKeyAttribute = @"postID";
    //[postMapping mapKeyPath:@"user_id" toAttribute:@"userID"];
    //#[postMapping mapKeyPath:@"topic_id" toAttribute:@"topicID"];
    
    [postMapping mapRelationship:@"post" withMapping:postMapping];
    [postMapping mapRelationship:@"topic" withMapping:topicMapping];
    [postMapping mapRelationship:@"author" withMapping:authorMapping];
    
    [objectManager.mappingProvider setMapping:postMapping forKeyPath:@"/posts"];

    // Tried this, was "too deep"
    // RKObjectMapping *postSerializationMapping = [postMapping inverseMapping];
    RKObjectMapping *postSerializationMapping = [RKObjectMapping 
                                                  mappingForClass:[Post class]]; 
    [postSerializationMapping mapKeyPath:@"postID" 
                              toAttribute:@"id"]; 
    [postSerializationMapping mapKeyPath:@"title" 
                              toAttribute:@"title"]; 
    [postSerializationMapping mapKeyPath:@"body" 
                              toAttribute:@"body"];
    [postSerializationMapping mapKeyPath:@"topicID" 
                             toAttribute:@"topic_id"]; 
    [postSerializationMapping mapKeyPath:@"authorID" 
                             toAttribute:@"author_id"]; 
        
    [objectManager.mappingProvider 
     setSerializationMapping:postSerializationMapping forClass:[Post class]];

    [objectManager.router routeClass:[Post class] toResourcePath:@"/posts/:postID"];

    [objectManager.router routeClass:[Post class] toResourcePath:@"/posts" forMethod:RKRequestMethodPOST];
    
    //TODO: Evaluate using :'s in routes
    // :list.listID/tasks/:taskID
    // [objectManager.router routeClass:[Post class] toResourcePath:@"/topics/:topic.topicID/posts/:postID"];
    
#pragma mark - Reskit Author Model Setup
    
    [authorMapping mapKeyPathsToAttributes:@"id", @"authorID",
     @"email", @"email",
     @"username", @"userName",
     nil];
    authorMapping.primaryKeyAttribute = @"authorID";
    
    //[authorMapping mapRelationship:@"post" withMapping:postMapping];
    
    [objectManager.mappingProvider setMapping:authorMapping forKeyPath:@"/authors"];
    
    RKObjectMapping *authorSerializationMapping = [RKObjectMapping 
                                                 mappingForClass:[Author class]]; 
    [authorSerializationMapping mapKeyPath:@"authorID" 
                             toAttribute:@"id"]; 
    [authorSerializationMapping mapKeyPath:@"email" 
                             toAttribute:@"email"]; 
    [authorSerializationMapping mapKeyPath:@"userName" 
                             toAttribute:@"username"];
    
    [objectManager.mappingProvider 
     setSerializationMapping:authorSerializationMapping forClass:[Author class]];
   
    [objectManager.router routeClass:[Author class] toResourcePath:@"/authors/:authorID"];
    
    [objectManager.router routeClass:[Author class] toResourcePath:@"/authors" forMethod:RKRequestMethodPOST];
}

//- (BOOL) isDatabaseResetNeeded {
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    BOOL needsReset = [[NSUserDefaults standardUserDefaults] boolForKey:kResetSavedDatabaseKey];
//    
//    if (needsReset) {
//        
//        [SLFAlertView showWithTitle:NSLocalizedStringFromTable(@"Settings: Reset Data to Factory?", @"AppAlerts", @"Confirmation to delete and reset the app's database.")
//                            message:NSLocalizedStringFromTable(@"Are you sure you want to reset the legislative database?  NOTE: The application may quit after this reset.  New data will be downloaded automatically via the Internet during the next app launch.", @"AppAlerts",@"") 
//                        cancelTitle:NSLocalizedStringFromTable(@"Cancel",@"StandardUI",@"Cancelling some activity")
//                        cancelBlock:^(void)
//         {
//             [self doDataReset:NO];
//         }
//                         otherTitle:NSLocalizedStringFromTable(@"Reset", @"StandardUI", @"Reset application settings to defaults")
//                         otherBlock:^(void)
//         {
//             [self doDataReset:YES];
//         }];
//    }
//    return needsReset;
//}
//
//- (void)doDataReset:(BOOL)doReset {
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kResetSavedDatabaseKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    if (doReset) {
//        [self resetSavedDatabase:nil]; 
//    }
//}
//
//- (void) resetSavedDatabase:(id)sender {
//    RKManagedObjectStore *objectStore = [[RKObjectManager sharedManager] objectStore];
//    [objectStore deletePersistantStore];
//    [objectStore save];    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"DATA_STORE_RELOAD" object:nil];
//    
//}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ldtrkpoc2" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ldtrkpoc2.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
