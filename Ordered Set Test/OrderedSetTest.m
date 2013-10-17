//
//  OrderedSetTest.m
//  Ordered Set Test
//
//  Created by Basil Shkara on 25/09/2013.
//  Copyright (c) 2013 Basil Shkara. All rights reserved.
//

#import "OrderedSetTest.h"
#import "EntityParent.h"
#import "EntityChild.h"
#import "NSMutableOrderedSet+DiffPatch.h"

@interface OrderedSetTest()
	@property (nonatomic, strong) NSPersistentStoreCoordinator *coordinator;
@end

@implementation OrderedSetTest


- (id)initWithCoordinator:(NSPersistentStoreCoordinator *)coordinator {
	self = [super init];
	if (self) {
		self.coordinator = coordinator;
	}

	return self;
}

- (void)run {
	NSManagedObjectContext *confinedContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSConfinementConcurrencyType];

	NSManagedObjectContext *parentContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
	parentContext.persistentStoreCoordinator = self.coordinator;

	confinedContext.parentContext = parentContext;

	EntityParent *parent = [NSEntityDescription insertNewObjectForEntityForName:@"EntityParent" inManagedObjectContext:confinedContext];
	NSMutableOrderedSet *childrenProxy = [parent mutableOrderedSetValueForKey:@"children"];

	for (int i=0; i<300; i++) {
		EntityChild *child = [NSEntityDescription insertNewObjectForEntityForName:@"EntityChild" inManagedObjectContext:confinedContext];
		[childrenProxy addObject:child];

		if (i == 150) {
			NSLog(@"SAVING CONFINED");
			[confinedContext save:nil];

			// This persists it to disk because we're saving the parent context and it is the parent context which manages the store
			[parentContext performBlockAndWait:^{
				NSLog(@"SAVING PARENT");
				[parentContext save:nil];
			}];
		}
	}

	NSLog(@"SAVING CONFINED AGAIN %lu",childrenProxy.count);
	[confinedContext save:nil];
	NSLog(@"DONE WITH %lu",childrenProxy.count);
}


@end
