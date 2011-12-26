//
//  PostsTableViewController.m
//  ldtrkpoc2
//
//  Created by Shane Zatezalo on 12/13/11.
//  Copyright (c) 2011 Lottadot LLC All rights reserved.
//

#import "PostsTableViewController.h"
#import <CoreData/CoreData.h>
#import "CoreDataTableViewController.h"
#import "MyModelEntities.h"
#import <RestKit/RestKit.h>
#import "PostEditorViewController.h"

@interface PostsTableViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)setupPostsFetchedResultsController;
- (void)fetchPostsDataFromRemote;
- (NSIndexPath *)indexPathForObject:(id)object;
@end

@implementation PostsTableViewController

@synthesize topic = _topic;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self fetchPostsDataFromRemote];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.debug = YES;
    //[self performFetch];
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
    
    static NSString *reuseIdentifier = @"Post Cell";
    
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	}
    [self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        
        Post *post = (Post *)[self.fetchedResultsController objectAtIndexPath:indexPath];
        
        if ([[post postID] intValue] <1) {
            // The topic was never synced to the Backend, just delete it from the MOC
            [[[[RKObjectManager sharedManager] objectStore] managedObjectContext ] deleteObject:post];
        } else {
            [[RKObjectManager sharedManager] deleteObject:post delegate:self];
        }
	}   
}

- (NSIndexPath *)indexPathForObject:(id)object {
    NSIndexPath *returnValue = nil;
    NSArray *visible = [self.tableView indexPathsForVisibleRows];
    for (int i=0; i < [visible count]; i++) {
        NSIndexPath *indexPath = (NSIndexPath*)[visible objectAtIndex:i];
        //id rowObject = [self.tableView objectAtIndex:indexPath.row];
        id rowObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        
        if ([rowObject isEqual:object]) {
            returnValue = indexPath;
        }
    }
    return returnValue;
}

#pragma mark - Table Cell 

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {   
    //TODO
    Post *post = [self.fetchedResultsController objectAtIndexPath:indexPath];
	//cell.textLabel.text = @"something"; // [[aPost objectAtIndex:indexPath.row] title];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (id:%i)",[post title],[[post postID] intValue]];
    
    NSString *subTitle = [[post author] userName];
    NSRange stringRange = {0, MIN([subTitle length], 40)};
    // adjust the range to include dependent chars
    stringRange = [subTitle rangeOfComposedCharacterSequencesForRange:stringRange];
    cell.detailTextLabel.text = [subTitle substringWithRange:stringRange];
}


#pragma mark -
#pragma mark Fetched results controller

- (void)setupPostsFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    if (nil == self.fetchedResultsController) {       
        //NSManagedObjectContext *managedObjectContext = [ApplicationDelegate managedObjectContext];
        
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Post"];
        request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
        // a predicate because we want ALL the Posts that belong to the topic 
        //request.predicate = [NSPredicate predicateWithFormat:@"post.topicID = %@", self.topic.topicID];
        request.predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"topicID = %i",[self.topic.topicID intValue]]];
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:self.topic.managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
        
        
    }
}

- (void)fetchPostsDataFromRemote {
    // Load the object model via RestKit	
    RKObjectManager* objectManager = [RKObjectManager sharedManager];
    NSString *url = [NSString stringWithFormat:@"/topics/%d/posts",[[self.topic topicID] intValue]];
    [objectManager loadObjectsAtResourcePath:url delegate:self 
                                       block:^(RKObjectLoader* loader) {
                                           // The backend returns posts as a naked array in JSON, so we instruct the loader
                                           // to user the appropriate object mapping
                                           loader.objectMapping = [objectManager.mappingProvider objectMappingForClass:[Post class]];
                                       }];
}

#pragma mark - RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	NSLog(@"objectLoader didLoadObjects: %@", objects);
	//[self loadObjectsFromDataStore];
    //[self performFetch];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                    message:[error localizedDescription] 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
	[alert show];
	NSLog(@"Hit error: %@", error);
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObject:(id)object {
    if ([object class] == [Post class]) {
        /* we pushed a Post object to the Server and are notified by RestKit's RKObjectLoader's Delegate Protocol that it was a success.
         If it was a new object, the new object would have a new ID value, so the table should be updated
         */
         //[self.tableView reloadData];
        NSIndexPath *indexPath = [self indexPathForObject:object];
        if (indexPath) {
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }

    }
   
}

#pragma mark topic

- (void)setTopic:(Topic *)topic {
    _topic = topic;
    self.title = topic.title;
    [self setupPostsFetchedResultsController];
}


#pragma mark Segue

// Support segueing from this table to any view controller that has a Post @property.

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Post *clicked = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    // be somewhat generic here (slightly advanced usage)
//    // we'll segue to ANY view controller that has a photographer @property
//    if ([segue.destinationViewController respondsToSelector:@selector(setPost:)]) {
//        // use performSelector:withObject: to send without compiler checking
//        // (which is acceptable here because we used introspection to be sure this is okay)
//        [segue.destinationViewController performSelector:@selector(setPost:) withObject:clicked];
//    }
    // be somewhat generic here (slightly advanced usage)
    // we'll segue to ANY view controller that has a photographer @property
    if ([@"addPost" isEqualToString:segue.identifier]) {
        /*
         the segue’s destinationViewController is not the editor view controller, but rather a navigation controller
         */
        Post *newPost = nil;
        newPost = (Post *)[NSEntityDescription 
                             insertNewObjectForEntityForName:@"Post" 
                             inManagedObjectContext:self.fetchedResultsController.managedObjectContext];
        
        [newPost setTitle:@"title text"];
        [newPost setBody:@"body text"];
        
        /* TODO: Not sure what I've got to setup at this point. I tried setTopic: (alone, without a setTopicId) and the POST of that 
         errored with: 
         *** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<Post 0x6ea4110> valueForUndefinedKey:]: the entity Post is not key value coding-compliant for the key "topic_id".'
         I think because newPost.topicID = 0 
         */
        [newPost setTopic:self.topic];
        [newPost setTopicID:self.topic.topicID];
        
        
        
        // TODO: Author Must be defined. OR the UI when editting a Post needs to let the user select an Author
//        RKObjectManager* objectManager = [RKObjectManager sharedManager];
//        [objectManager loadObjectsAtResourcePath:@"/authors" delegate:self 
//                                           block:^(RKObjectLoader* loader) {
//                                               // The backend returns topics as a naked array in JSON, so we instruct the loader
//                                               // to user the appropriate object mapping
//                                               loader.objectMapping = [objectManager.mappingProvider objectMappingForClass:[Author class]];
//                                               // author = [[loader objectAtIndex] lastObject];
//                                           }];
//         //[responseLoader.objects lastObject];

        
  
        NSFetchRequest *request = [Author fetchRequest];
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
        NSArray *authors = [Author objectsWithFetchRequest:request];

        if (nil != authors && [authors count]) {
            Author *author = [authors lastObject];
            [newPost setAuthor:author];
            [newPost setAuthorID:author.authorID];
        }
                  
        UIViewController *topVC = [[segue destinationViewController] topViewController];
        PostEditorViewController *editor = (PostEditorViewController *)topVC;
        editor.post = newPost;
        editor.postsViewController = self;
    } else if ([segue.destinationViewController respondsToSelector:@selector(setPost:)]) {
        // use performSelector:withObject: to send without compiler checking
        // (which is acceptable here because we used introspection to be sure this is okay)
        [segue.destinationViewController performSelector:@selector(setPost:) withObject:clicked];
    } 
}

#pragma mark Actions

// back from the editting controller

- (void)finishedEditing:(Post *)aPost AndCancelled:(BOOL)cancelled {
    if (nil != aPost && !cancelled) {
        //[[RKObjectManager sharedManager] postObject:aPost delegate:self];
        [[RKObjectManager sharedManager] postObject:aPost delegate:self block:^(RKObjectLoader *loader) { 
            // Skip the object serializer and provide it yourself 
            // No reason to try a 
            //[self.tableView reloadData];
            // here, we will attempt to reload the row in - (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObject:(id)object

                NSIndexPath *indexPath = [self indexPathForObject:aPost];
                if (indexPath) {
                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }

            
        }]; 
        
    } else if (nil != aPost && cancelled) {
        if ([[aPost postID] intValue] <1) {
            // The post was a new post, but it was cancelled. It needs to be deleted out of the MOC
            // Normally, we would used RestKit's ObjectManager to delete the object. It would contact the remote server and delete it there too.
            // But doing this for an object that has no remote key (Topic.topicID) will cause Restkit to throw an 
            // 'Unable to find a routable path for object of type '(null)' for HTTP Method 'DELETE''
            // so rather then do this
            //[[RKObjectManager sharedManager] deleteObject:aTopic delegate:self];
            // we delete it right out of the MOC
            [[[[RKObjectManager sharedManager] objectStore] managedObjectContext ] deleteObject:aPost];
        }
    }
    [self dismissModalViewControllerAnimated:YES];
}

@end
