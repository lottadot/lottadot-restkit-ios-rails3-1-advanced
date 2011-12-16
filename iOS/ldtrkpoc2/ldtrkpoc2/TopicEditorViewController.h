//
//  TopicEditorViewController.h
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/15/11.
//  Copyright (c) 2011 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Topic;

@interface TopicEditorViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) Topic *topic;
@property (nonatomic, strong) IBOutlet UITextField *titleField;
@property (nonatomic, strong) IBOutlet UITextView *bodyText;

- (IBAction)done:(UIBarButtonItem *)sender;

@end
