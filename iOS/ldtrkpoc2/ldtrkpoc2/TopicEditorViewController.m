//
//  TopicEditorViewController.m
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/15/11.
//  Copyright (c) 2011 Lottadot LLC. All rights reserved.
//

#import "TopicEditorViewController.h"
#import "MyModelEntities.h"
#import "TopicsTableViewController.h"

@implementation TopicEditorViewController

@synthesize topic, titleField, bodyText, topicsViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Edit Topic";
    self.titleField.text = self.topic.title;
    [self.titleField becomeFirstResponder];
    self.bodyText.text = self.topic.body;
}

- (void)viewWillDisappear:(BOOL)animated { 
    [super viewWillDisappear:animated]; 
    [self.titleField resignFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    //[[RKClient sharedClient].requestQueue cancelRequestsWithDelegate:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Text Field Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField { [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField { 
    self.topic.title = self.titleField.text;
}

- (void)textViewDidEndEditing:(UITextView *)textView { 
    self.topic.body = self.bodyText.text;
}

#pragma mark - Actions

- (IBAction)done:(UIBarButtonItem *)sender {
    self.topic.title = self.titleField.text;
    self.topic.body = self.bodyText.text;
    [self.topicsViewController finishedEditing:self.topic AndCancelled:NO];
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self.topicsViewController finishedEditing:self.topic AndCancelled:YES];
}

@end
