// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Post.h instead.

#import <CoreData/CoreData.h>
#import "RootManagedObjectClass.h"

extern const struct PostAttributes {
	__unsafe_unretained NSString *authorID;
	__unsafe_unretained NSString *body;
	__unsafe_unretained NSString *postID;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *topicID;
} PostAttributes;

extern const struct PostRelationships {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *topic;
} PostRelationships;

extern const struct PostFetchedProperties {
} PostFetchedProperties;

@class Author;
@class Topic;







@interface PostID : NSManagedObjectID {}
@end

@interface _Post : RootManagedObjectClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PostID*)objectID;




@property (nonatomic, strong) NSNumber *authorID;


@property short authorIDValue;
- (short)authorIDValue;
- (void)setAuthorIDValue:(short)value_;

//- (BOOL)validateAuthorID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *body;


//- (BOOL)validateBody:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *postID;


@property short postIDValue;
- (short)postIDValue;
- (void)setPostIDValue:(short)value_;

//- (BOOL)validatePostID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber *topicID;


@property short topicIDValue;
- (short)topicIDValue;
- (void)setTopicIDValue:(short)value_;

//- (BOOL)validateTopicID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Author* author;

//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Topic* topic;

//- (BOOL)validateTopic:(id*)value_ error:(NSError**)error_;




@end

@interface _Post (CoreDataGeneratedAccessors)

@end

@interface _Post (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAuthorID;
- (void)setPrimitiveAuthorID:(NSNumber*)value;

- (short)primitiveAuthorIDValue;
- (void)setPrimitiveAuthorIDValue:(short)value_;




- (NSString*)primitiveBody;
- (void)setPrimitiveBody:(NSString*)value;




- (NSNumber*)primitivePostID;
- (void)setPrimitivePostID:(NSNumber*)value;

- (short)primitivePostIDValue;
- (void)setPrimitivePostIDValue:(short)value_;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




- (NSNumber*)primitiveTopicID;
- (void)setPrimitiveTopicID:(NSNumber*)value;

- (short)primitiveTopicIDValue;
- (void)setPrimitiveTopicIDValue:(short)value_;





- (Author*)primitiveAuthor;
- (void)setPrimitiveAuthor:(Author*)value;



- (Topic*)primitiveTopic;
- (void)setPrimitiveTopic:(Topic*)value;


@end
