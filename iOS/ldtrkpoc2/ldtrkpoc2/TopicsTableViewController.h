//
//  LDTViewController.h
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/8/11.
//  Copyright (c) 2011 Lottadot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataTableViewController.h"

@class Topic, Post, Author;

@interface TopicsTableViewController : CoreDataTableViewController <RKObjectLoaderDelegate> {
    
}

- (void)finishedEditing:(Topic *)aTopic AndCancelled:(BOOL)cancelled;

@end
