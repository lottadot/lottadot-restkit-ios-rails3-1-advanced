//
//  AuthorsTableViewController.h
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/13/11.
//  Copyright (c) 2011 Lottadot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataTableViewController.h"

@class Topic, Post, Author;

@interface AuthorsTableViewController : CoreDataTableViewController <RKObjectLoaderDelegate> {
    
}

@property (nonatomic, strong) Post *post;

@end

