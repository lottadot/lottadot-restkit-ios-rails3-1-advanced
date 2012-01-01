//
//  PostEditorViewController.h
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/26/11.
//  Copyright (c) 2011 Lottadot LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Post, PostsTableViewController;

@interface PostEditorViewController : UIViewController

@property (nonatomic, strong) Post *post;
@property (nonatomic, strong) IBOutlet UITextField *titleField;
@property (nonatomic, strong) IBOutlet UITextView *bodyText;
@property (nonatomic, weak) PostsTableViewController *postsViewController;

- (IBAction)done:(UIBarButtonItem *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;

@end
