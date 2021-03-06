//
//  LDTViewController.m
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/8/11.
//  Copyright (c) 2011 Lottadot LLC All rights reserved.
//

#import "TopicsTableViewController.h"
#import <CoreData/CoreData.h>
#import "CoreDataTableViewController.h"
#import "MyModelEntities.h"
#import <RestKit/RestKit.h>
#import "TopicEditorViewController.h"

@interface TopicsTableViewController (Private)
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)setupFetchedResultsController;
- (void)fetchTopicDataFromRemote;
- (void)deleteAllObjects:(NSString *)entityDescription;
@end

@implementation TopicsTableViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [[RKClient sharedClient].requestQueue cancelRequestsWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (nil == self.fetchedResultsController) {
        [self setupFetchedResultsController];
    }
    [self fetchTopicDataFromRemote];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Table view methods


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"Topic Cell";
    
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	}
    [self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        
        Topic *topic = (Topic *)[self.fetchedResultsController objectAtIndexPath:indexPath];

        if ([[topic topicID] intValue] <1) {
            // The topic was never synced to the Backend, just delete it from the MOC
            [[[[RKObjectManager sharedManager] objectStore] managedObjectContext ] deleteObject:topic];
        } else {
            [[RKObjectManager sharedManager] deleteObject:topic delegate:self];
        }
	}   
}

#pragma mark - Table Cell 

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {   
    //TODO
    Topic *topic = (Topic *)[self.fetchedResultsController objectAtIndexPath:indexPath];
	//cell.textLabel.text = @"something"; // [[aPost objectAtIndex:indexPath.row] title];
    cell.textLabel.text = [topic title];
    
    NSString *subTitle = [topic body];
    NSRange stringRange = {0, MIN([subTitle length], 40)};
    // adjust the range to include dependent chars
    stringRange = [subTitle rangeOfComposedCharacterSequencesForRange:stringRange];
    cell.detailTextLabel.text = [subTitle substringWithRange:stringRange];
}


#pragma mark -
#pragma mark Fetched results controller

/*
 Described by: Panupan Sriautharawong <panupan@willinteractive.com>
 Restkit keeps one managed object context (MOC) per thread. Since
 remoting is asynchronous, the calls and work occur on a separate
 thread, and when the response comes back, Restkit does the work in a
 MOC on that thread. Don't worry though, Restkit merges these changes
 back to the main MOC for you automatically. Bottom line is, your
 application should use the main MOC retrievable at: [[RKObjectManager
 sharedManager].objectStore managedObjectContext].
*/

- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    if (nil == self.fetchedResultsController) { 
        //Ancient Way:
        //Normally one would use the MOC From the Main Thread/AppDelegate to fetch against 
        //However with RestKit we do not need to.
        //NSManagedObjectContext *managedObjectContext = [ApplicationDelegate managedObjectContext];

//        // Old Way
//        // We'd create a FetchRequest and tell the request to use the Moc from RestKit
//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Topic"];
//        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
//        // no predicate because we want ALL the Topics
//        
//        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
//                                                                            //managedObjectContext:managedObjectContext
//                                                                            managedObjectContext: [[RKObjectManager
//                                                                                                    sharedManager].objectStore managedObjectContext]
//                                                                              sectionNameKeyPath:nil
//                                                                                       cacheName:nil];

        
        self.fetchedResultsController = [Topic fetchAllSortedBy:@"title" ascending:YES withPredicate:nil groupBy:nil];
        
    }
}

- (void)fetchTopicDataFromRemote {
    // Load the object model via RestKit	
    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    [objectManager loadObjectsAtResourcePath:@"/topics" delegate:self 
                                       block:^(RKObjectLoader* loader) {
        // The backend returns topics as a naked array in JSON, so we instruct the loader
        // to user the appropriate object mapping
        loader.objectMapping = [objectManager.mappingProvider objectMappingForClass:[Topic class]];
    }];
}

#pragma mark -
#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	NSLog(@"Loaded topics: %@", objects);
	//[self loadObjectsFromDataStore];
    [self performFetch];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                     message:[error localizedDescription] 
                                                    delegate:nil 
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
	[alert show];
	NSLog(@"Hit error: %@", error);
}

#pragma mark Segue

// Support segueing from this table to any view controller that has a Topic @property.

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Topic *clicked = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // be somewhat generic here (slightly advanced usage)
    // we'll segue to ANY view controller that has a photographer @property
    if ([@"addTopic" isEqualToString:segue.identifier]) {
        /*
         the segue’s destinationViewController is not the editor view controller, but rather a navigation controller
         */
        Topic *newTopic = nil;
        newTopic = (Topic *)[NSEntityDescription 
                  insertNewObjectForEntityForName:@"Topic" 
                  inManagedObjectContext:self.fetchedResultsController.managedObjectContext];
 
        [newTopic setTitle:@"title text"];
        [newTopic setBody:@"body text"];

        UIViewController *topVC = [[segue destinationViewController] topViewController];
        TopicEditorViewController *editor = (TopicEditorViewController *)topVC;
        editor.topic = newTopic;
        editor.topicsViewController = self;
    } else if ([segue.destinationViewController respondsToSelector:@selector(setTopic:)]) {
        // use performSelector:withObject: to send without compiler checking
        // (which is acceptable here because we used introspection to be sure this is okay)
        [segue.destinationViewController performSelector:@selector(setTopic:) withObject:clicked];
    } 
}

#pragma mark Actions

// back from the editting controller

- (void)finishedEditing:(Topic *)aTopic AndCancelled:(BOOL)cancelled {
    if (nil != aTopic && !cancelled) {
        // Rails 3 defaults to not encapsulating the returned object { "topic" : { "id" : 999, ....
        // The only way this will work, 
        // http://groups.google.com/group/restkit/browse_thread/thread/2463f121ae851976/c4f46703ddbedc6b?lnk=gst&q=postObject+block#c4f46703ddbedc6b
        
        [[RKObjectManager sharedManager] postObject:aTopic delegate:self block:^(RKObjectLoader* loader) { 
            loader.resourcePath = @"/topics";
            // if you don't want to map the response back onto the original object being POST'd, 
            // you can just nil out the targetObject.
            // When the target object is nil RestKit will instantiate new target 
            // objects (or look them up if using Core Data) 
            //loader.targetObject = nil;
            loader.objectMapping = [[RKObjectManager sharedManager].mappingProvider objectMappingForKeyPath:@"/topics"]; 
        }]; 
        
    } else if (nil != aTopic && cancelled) {
        if ([[aTopic topicID] intValue] <1) {
            // The topic was a new topic, but it was cancelled. It needs to be deleted out of the MOC
            // Normally, we would used RestKit's ObjectManager to delete the object. It would contact the remote server and delete it there too.
            // But doing this for an object that has no remote key (Topic.topicID) will cause Restkit to throw an 
            // 'Unable to find a routable path for object of type '(null)' for HTTP Method 'DELETE''
            // so rather then do this
            //[[RKObjectManager sharedManager] deleteObject:aTopic delegate:self];
            // we delete it right out of the MOC
            [[[[RKObjectManager sharedManager] objectStore] managedObjectContext ] deleteObject:aTopic];
        }
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)deleteAllButtonClicked:(id)sender {
    NSArray* objects = [Topic findAll]; 
    for (Topic *object in objects) { 
        [[Topic managedObjectContext] deleteObject:object]; 
    } 
    NSError* error = nil; 
    [[Topic managedObjectContext] save:&error]; 
    if (nil != error) { 
        // Error checking here... 
    }
    [self.tableView reloadData];
}

- (IBAction)refreshButtonClicked:(id)sender {
    [self fetchTopicDataFromRemote];
}

@end
