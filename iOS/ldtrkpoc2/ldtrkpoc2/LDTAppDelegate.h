//
//  LDTAppDelegate.h
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/8/11.
//  Copyright (c) 2011 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@class Topic, Post, Author;

@interface LDTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

#define ApplicationDelegate ((LDTAppDelegate *)[UIApplication sharedApplication].delegate)

@end
