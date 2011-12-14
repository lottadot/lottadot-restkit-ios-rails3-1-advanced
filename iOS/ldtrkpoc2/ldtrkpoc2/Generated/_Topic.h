// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Topic.h instead.

#import <CoreData/CoreData.h>
#import "RootManagedObjectClass.h"

extern const struct TopicAttributes {
	__unsafe_unretained NSString *body;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *topicID;
} TopicAttributes;

extern const struct TopicRelationships {
	__unsafe_unretained NSString *posts;
} TopicRelationships;

extern const struct TopicFetchedProperties {
} TopicFetchedProperties;

@class Post;





@interface TopicID : NSManagedObjectID {}
@end

@interface _Topic : RootManagedObjectClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TopicID*)objectID;




@property (nonatomic, strong) NSNumber *body;


@property short bodyValue;
- (short)bodyValue;
- (void)setBodyValue:(short)value_;

//- (BOOL)validateBody:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *topicID;


@property short topicIDValue;
- (short)topicIDValue;
- (void)setTopicIDValue:(short)value_;

//- (BOOL)validateTopicID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* posts;

- (NSMutableSet*)postsSet;




@end

@interface _Topic (CoreDataGeneratedAccessors)

- (void)addPosts:(NSSet*)value_;
- (void)removePosts:(NSSet*)value_;
- (void)addPostsObject:(Post*)value_;
- (void)removePostsObject:(Post*)value_;

@end

@interface _Topic (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveBody;
- (void)setPrimitiveBody:(NSNumber*)value;

- (short)primitiveBodyValue;
- (void)setPrimitiveBodyValue:(short)value_;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




- (NSNumber*)primitiveTopicID;
- (void)setPrimitiveTopicID:(NSNumber*)value;

- (short)primitiveTopicIDValue;
- (void)setPrimitiveTopicIDValue:(short)value_;





- (NSMutableSet*)primitivePosts;
- (void)setPrimitivePosts:(NSMutableSet*)value;


@end
