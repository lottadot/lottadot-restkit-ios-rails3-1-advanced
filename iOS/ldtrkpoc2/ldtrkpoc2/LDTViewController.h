//
//  LDTViewController.h
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/8/11.
//  Copyright (c) 2011 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface LDTViewController : UIViewController <UITableViewDelegate> {
    
    @private
        NSFetchedResultsController *fetchedResultsController;
        NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
