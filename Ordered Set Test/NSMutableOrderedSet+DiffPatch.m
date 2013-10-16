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
	[NSMutableOrderedSet jr_swizzleMethod:@selector(insertObjects:atIndexes:) withMethod:@selector(ost_insertObjects:atIndexes:) error:nil];
}

- (void)ost_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
	if ([indexes ost_containsMultipleRanges]) {
		[self addObjectsFromArray:objects];
	} else {
		[self ost_insertObjects:objects atIndexes:indexes];
	}
}


// TODO Occurs in situations where we have a parent context and a confined context is saving to it by flushing periodically
// TODO Test on 10.8


@end
