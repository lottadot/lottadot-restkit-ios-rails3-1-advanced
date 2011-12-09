// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Post.h instead.

#import <CoreData/CoreData.h>
#import "RootManagedObjectClass.h"

extern const struct PostAttributes {
	__unsafe_unretained NSString *body;
	__unsafe_unretained NSString *title;
} PostAttributes;

extern const struct PostRelationships {
	__unsafe_unretained NSString *topic;
} PostRelationships;

extern const struct PostFetchedProperties {
} PostFetchedProperties;

@class Topic;




@interface PostID : NSManagedObjectID {}
@end

@interface _Post : RootManagedObjectClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PostID*)objectID;




@property (nonatomic, strong) NSString *body;


//- (BOOL)validateBody:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString *title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Topic* topic;

//- (BOOL)validateTopic:(id*)value_ error:(NSError**)error_;




@end

@interface _Post (CoreDataGeneratedAccessors)

@end

@interface _Post (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveBody;
- (void)setPrimitiveBody:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (Topic*)primitiveTopic;
- (void)setPrimitiveTopic:(Topic*)value;


@end
