//
//  NSMutableOrderedSet+DiffPatch.m
//  Ordered Set Test
//
//  Created by Basil Shkara on 17/10/2013.
//  Copyright (c) 2013 Basil Shkara. All rights reserved.
//

#import "NSMutableOrderedSet+DiffPatch.h"
#import "NSIndexSet+Ranges.h"
#import "JRSwizzle.h"

@implementation NSMutableOrderedSet (DiffPatch)


+ (void)load {
	// This patch only needed for 10.9
	if (floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_8) {
		[NSMutableOrderedSet jr_swizzleMethod:@selector(insertObjects:atIndexes:) withMethod:@selector(ost_insertObjects:atIndexes:) error:nil];
	}
}

- (void)ost_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
	@try {
		[self ost_insertObjects:objects atIndexes:indexes];
	}
	@catch (NSException *exception) {
		NSLog(@"CATCH");
		if ([indexes ost_containsMultipleRanges]) {
			[self addObjectsFromArray:objects];
		} else {
			@throw(exception);
		}
	}
}


@end
