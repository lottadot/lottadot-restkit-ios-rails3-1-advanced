// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Topic.m instead.

#import "_Topic.h"

const struct TopicAttributes TopicAttributes = {
	.body = @"body",
	.title = @"title",
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
	

	return keyPaths;
}




@dynamic body;






@dynamic title;






@dynamic posts;

	
- (NSMutableSet*)postsSet {
	[self willAccessValueForKey:@"posts"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"posts"];
  
	[self didAccessValueForKey:@"posts"];
	return result;
}
	





@end
