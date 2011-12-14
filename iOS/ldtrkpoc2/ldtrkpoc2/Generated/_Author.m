// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Author.m instead.

#import "_Author.h"

const struct AuthorAttributes AuthorAttributes = {
	.authorID = @"authorID",
	.email = @"email",
	.userName = @"userName",
};

const struct AuthorRelationships AuthorRelationships = {
	.posts = @"posts",
};

const struct AuthorFetchedProperties AuthorFetchedProperties = {
};

@implementation AuthorID
@end

@implementation _Author

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Author" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Author";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Author" inManagedObjectContext:moc_];
}

- (AuthorID*)objectID {
	return (AuthorID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"authorIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"authorID"];
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





@dynamic email;






@dynamic userName;






@dynamic posts;

	
- (NSMutableSet*)postsSet {
	[self willAccessValueForKey:@"posts"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"posts"];
  
	[self didAccessValueForKey:@"posts"];
	return result;
}
	





@end
