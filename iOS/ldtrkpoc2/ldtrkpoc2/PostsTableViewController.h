//
//  PostsTableViewController.h
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/13/11.
//  Copyright (c) 2011 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataTableViewController.h"

@class Topic, Post, Author;

@interface PostsTableViewController : CoreDataTableViewController <RKObjectLoaderDelegate> {
    
}

@property (nonatomic, strong) Topic *topic;

@end
