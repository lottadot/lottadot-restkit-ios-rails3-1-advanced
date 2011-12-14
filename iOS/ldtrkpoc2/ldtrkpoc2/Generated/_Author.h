// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Author.h instead.

#import <CoreData/CoreData.h>
#import "RootManagedObjectClass.h"

extern const struct AuthorAttributes {
	__unsafe_unretained NSString *authorID;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *userName;
} AuthorAttributes;

extern const struct AuthorRelationships {
	__unsafe_unretained NSString *posts;
} AuthorRelationships;

extern const struct AuthorFetchedProperties {
} AuthorFetchedProperties;

@class Post;





@interface AuthorID : NSManagedObjectID {}
@end

@interface _Author : RootManagedObjectClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AuthorID*)objectID;




@property (nonatomic, strong) NSNumber *authorID;


@property short authorIDValue;
- (short)authorIDValue;
- (void)setAuthorIDValue:(short)value_;

//- (BOOL)validateAuthorID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *email;


//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *userName;


//- (BOOL)validateUserName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* posts;

- (NSMutableSet*)postsSet;




@end

@interface _Author (CoreDataGeneratedAccessors)

- (void)addPosts:(NSSet*)value_;
- (void)removePosts:(NSSet*)value_;
- (void)addPostsObject:(Post*)value_;
- (void)removePostsObject:(Post*)value_;

@end

@interface _Author (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAuthorID;
- (void)setPrimitiveAuthorID:(NSNumber*)value;

- (short)primitiveAuthorIDValue;
- (void)setPrimitiveAuthorIDValue:(short)value_;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveUserName;
- (void)setPrimitiveUserName:(NSString*)value;





- (NSMutableSet*)primitivePosts;
- (void)setPrimitivePosts:(NSMutableSet*)value;


@end
