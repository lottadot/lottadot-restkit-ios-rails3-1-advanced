//
//  PostEditorViewController.m
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/26/11.
//  Copyright (c) 2011 Lottadot LLC. All rights reserved.
//

#import "PostEditorViewController.h"
#import "MyModelEntities.h"
#import "PostsTableViewController.h"

@implementation PostEditorViewController

@synthesize post, titleField, bodyText, postsViewController;

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
    self.title = @"Edit Post";
    self.titleField.text = self.post.title;
    [self.titleField becomeFirstResponder];
    self.bodyText.text = self.post.body;
}

- (void)viewWillDisappear:(BOOL)animated { 
    [super viewWillDisappear:animated]; 
    [self.titleField resignFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    self.post.title = self.titleField.text;
}

- (void)textViewDidEndEditing:(UITextView *)textView { 
    self.post.body = self.bodyText.text;
}

#pragma mark - Actions

- (IBAction)done:(UIBarButtonItem *)sender {
    self.post.title = self.titleField.text;
    self.post.body = self.bodyText.text;
    [self.postsViewController finishedEditing:self.post AndCancelled:NO];
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self.postsViewController finishedEditing:self.post AndCancelled:YES];
}


@end
