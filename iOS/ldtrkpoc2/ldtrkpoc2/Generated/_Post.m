// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Post.m instead.

#import "_Post.h"

const struct PostAttributes PostAttributes = {
	.authorID = @"authorID",
	.body = @"body",
	.postID = @"postID",
	.title = @"title",
	.topicID = @"topicID",
};

const struct PostRelationships PostRelationships = {
	.author = @"author",
	.topic = @"topic",
};

const struct PostFetchedProperties PostFetchedProperties = {
};

@implementation PostID
@end

@implementation _Post

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Post";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Post" inManagedObjectContext:moc_];
}

- (PostID*)objectID {
	return (PostID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"authorIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"authorID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"postIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"postID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"topicIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"topicID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic authorID;



- (short)authorIDValue {
	NSNumber *result = [self authorID];
	return [result shortValue];
}

- (void)setAuthorIDValue:(short)value_ {
	[self setAuthorID:[NSNumber numberWithShort:value_]];
}

- (short)primitiveAuthorIDValue {
	NSNumber *result = [self primitiveAuthorID];
	return [result shortValue];
}

- (void)setPrimitiveAuthorIDValue:(short)value_ {
	[self setPrimitiveAuthorID:[NSNumber numberWithShort:value_]];
}





@dynamic body;






@dynamic postID;



- (short)postIDValue {
	NSNumber *result = [self postID];
	return [result shortValue];
}

- (void)setPostIDValue:(short)value_ {
	[self setPostID:[NSNumber numberWithShort:value_]];
}

- (short)primitivePostIDValue {
	NSNumber *result = [self primitivePostID];
	return [result shortValue];
}

- (void)setPrimitivePostIDValue:(short)value_ {
	[self setPrimitivePostID:[NSNumber numberWithShort:value_]];
}





@dynamic title;






@dynamic topicID;



- (short)topicIDValue {
	NSNumber *result = [self topicID];
	return [result shortValue];
}

- (void)setTopicIDValue:(short)value_ {
	[self setTopicID:[NSNumber numberWithShort:value_]];
}

- (short)primitiveTopicIDValue {
	NSNumber *result = [self primitiveTopicID];
	return [result shortValue];
}

- (void)setPrimitiveTopicIDValue:(short)value_ {
	[self setPrimitiveTopicID:[NSNumber numberWithShort:value_]];
}





@dynamic author;

	

@dynamic topic;

	





@end
