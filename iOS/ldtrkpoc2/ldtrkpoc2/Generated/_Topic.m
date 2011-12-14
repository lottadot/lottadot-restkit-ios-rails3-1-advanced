// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Topic.m instead.

#import "_Topic.h"

const struct TopicAttributes TopicAttributes = {
	.body = @"body",
	.title = @"title",
	.topicID = @"topicID",
};

const struct TopicRelationships TopicRelationships = {
	.posts = @"posts",
};

const struct TopicFetchedProperties TopicFetchedProperties = {
};

@implementation TopicID
@end

@implementation _Topic

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Topic" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Topic";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Topic" inManagedObjectContext:moc_];
}

- (TopicID*)objectID {
	return (TopicID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"bodyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"body"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"topicIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"topicID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic body;



- (short)bodyValue {
	NSNumber *result = [self body];
	return [result shortValue];
}

- (void)setBodyValue:(short)value_ {
	[self setBody:[NSNumber numberWithShort:value_]];
}

- (short)primitiveBodyValue {
	NSNumber *result = [self primitiveBody];
	return [result shortValue];
}

- (void)setPrimitiveBodyValue:(short)value_ {
	[self setPrimitiveBody:[NSNumber numberWithShort:value_]];
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





@dynamic posts;

	
- (NSMutableSet*)postsSet {
	[self willAccessValueForKey:@"posts"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"posts"];
  
	[self didAccessValueForKey:@"posts"];
	return result;
}
	





@end
