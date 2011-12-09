// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

#import <CoreData/CoreData.h>
#import "RootManagedObjectClass.h"

extern const struct UserAttributes {
} UserAttributes;

extern const struct UserRelationships {
	__unsafe_unretained NSString *posts;
} UserRelationships;

extern const struct UserFetchedProperties {
} UserFetchedProperties;

@class Post;


@interface UserID : NSManagedObjectID {}
@end

@interface _User : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (UserID*)objectID;





@property (nonatomic, strong) NSSet* posts;

- (NSMutableSet*)postsSet;




@end

@interface _User (CoreDataGeneratedAccessors)

- (void)addPosts:(NSSet*)value_;
- (void)removePosts:(NSSet*)value_;
- (void)addPostsObject:(Post*)value_;
- (void)removePostsObject:(Post*)value_;

@end

@interface _User (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitivePosts;
- (void)setPrimitivePosts:(NSMutableSet*)value;


@end
