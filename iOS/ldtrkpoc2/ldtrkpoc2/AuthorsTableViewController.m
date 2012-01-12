//
//  AuthorsTableViewController.m
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/13/11.
//  Copyright (c) 2011 Lottadot LLC. All rights reserved.
//

#import "AuthorsTableViewController.h"

#import "AuthorsTableViewController.h"
#import <CoreData/CoreData.h>
#import "CoreDataTableViewController.h"
#import "MyModelEntities.h"
#import <RestKit/RestKit.h>

@interface AuthorsTableViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)setupPostsFetchedResultsController;
- (void)fetchPostsDataFromRemote;
@end

@implementation AuthorsTableViewController

@synthesize post = _post;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	[[RKClient sharedClient].requestQueue cancelRequestsWithDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (nil == self.fetchedResultsController) {
        [self setupPostsFetchedResultsController];
        
    }
    self.debug = YES;
    //[self performFetch];
    NSLog(@"count:%i",[[self.fetchedResultsController sections] count]);
    //[self.tableView reloadData];
    [self fetchPostsDataFromRemote];
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
    
    static NSString *reuseIdentifier = @"Author Cell";
    
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	}
    [self configureCell:cell atIndexPath:indexPath];
	return cell;
}

#pragma mark - Table Cell 

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {   
    Author *author = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [author userName];
    cell.detailTextLabel.text = [author email];
}


#pragma mark -
#pragma mark Fetched results controller

- (void)setupPostsFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    if (nil == self.fetchedResultsController) {       
        //NSManagedObjectContext *managedObjectContext = [ApplicationDelegate managedObjectContext];
        
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Author"];
        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        // a predicate because we want ALL the Posts that belong to the topic 
        //request.predicate = [NSPredicate predicateWithFormat:@"post.topicID = %@", self.topic.topicID];
        request.predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"authorID = %i",[self.post.authorID intValue]]];
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:self.post.managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
        
        
    }
}

- (void)fetchPostsDataFromRemote {
    // Load the object model via RestKit	
    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    NSString *url = [NSString stringWithFormat:@"/authors"];
    [objectManager loadObjectsAtResourcePath:url delegate:self 
                                       block:^(RKObjectLoader* loader) {
                                           // The backend returns posts as a naked array in JSON, so we instruct the loader
                                           // to user the appropriate object mapping
                                           loader.objectMapping = [objectManager.mappingProvider objectMappingForClass:[Author class]];
                                       }];
}

#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	NSLog(@"Loaded authors: %@", objects);
	//[self loadObjectsFromDataStore];
    [self performFetch];
	//[self.tableView reloadData];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                    message:[error localizedDescription] 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
	[alert show];
	NSLog(@"Hit error: %@", error);
}

#pragma mark topic

- (void)setPost:(Post *)post {
    _post = post;
    self.title = post.author.userName;
    [self setupPostsFetchedResultsController];
}


#pragma mark Segue

// Support segueing from this table to any view controller that has a Post @property.

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Post *clicked = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // be somewhat generic here (slightly advanced usage)
    // we'll segue to ANY view controller that has a photographer @property
    if ([segue.destinationViewController respondsToSelector:@selector(setPost:)]) {
        // use performSelector:withObject: to send without compiler checking
        // (which is acceptable here because we used introspection to be sure this is okay)
        [segue.destinationViewController performSelector:@selector(setPost:) withObject:clicked];
    }
}

@end