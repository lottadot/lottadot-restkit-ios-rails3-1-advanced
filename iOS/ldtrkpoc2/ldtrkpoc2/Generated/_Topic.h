// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Topic.h instead.

#import <CoreData/CoreData.h>
#import "RootManagedObjectClass.h"

extern const struct TopicAttributes {
	__unsafe_unretained NSString *body;
	__unsafe_unretained NSString *title;
} TopicAttributes;

extern const struct TopicRelationships {
	__unsafe_unretained NSString *post;
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




@property (nonatomic, strong) NSString *body;


//- (BOOL)validateBody:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Post* post;

//- (BOOL)validatePost:(id*)value_ error:(NSError**)error_;




@end

@interface _Topic (CoreDataGeneratedAccessors)

@end

@interface _Topic (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveBody;
- (void)setPrimitiveBody:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (Post*)primitivePost;
- (void)setPrimitivePost:(Post*)value;


@end
