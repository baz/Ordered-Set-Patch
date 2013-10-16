//
//  NSIndexSet+Ranges.m
//  Ordered Set Test
//
//  Created by Basil Shkara on 17/10/2013.
//  Copyright (c) 2013 Basil Shkara. All rights reserved.
//

#import "NSIndexSet+Ranges.h"

@implementation NSIndexSet (Ranges)


/* Returns the first range of contiguous indices in the receiver greater than or equal to /fromIndex/.
 * Indices less than fromIndex are simply ignored, that is, if fromIndex is in the middle of a large range, then the returned range will start at fromIndex and continue to the end.
 *
 * From https://github.com/omnigroup/OmniGroup/blob/master/Frameworks/OmniFoundation/OpenStepExtensions.subproj/NSIndexSet-OFExtensions.m
 *
 * */
- (NSRange)ost_rangeGreaterThanOrEqualToIndex:(NSUInteger)fromIndex {
	fromIndex = [self indexGreaterThanOrEqualToIndex:fromIndex];

	if (fromIndex == NSNotFound) {
		return (NSRange){NSNotFound, 0};
	}

	// There isn't a direct way to extract the next contiguous range, even though NSIndexSet's internal representation is a sorted list of ranges --- so we do a binary search for the end of this range.

	NSRange result;
	result.location = fromIndex;
	result.length = 1;
	NSUInteger step = 1;

	while ([self containsIndexesInRange:(NSRange){ result.location, result.length + step }]) {
		result.length += step;
		step <<= 1;
	}
	// At this point, we know that we contain the indices in the 'result' range, but somewhere in the next 'step' indices there's one missing.
	// So we can do a normal binary search within that range.

	while(step > 1) {
		step >>= 1;
		BOOL afterFirstHalf = [self containsIndexesInRange:(NSRange){ result.location, result.length + step }];
		if (afterFirstHalf)
			result.length += step;
	}

	return result;
}

- (BOOL)ost_containsMultipleRanges {
	BOOL hasMultiple = NO;

	if ([self count] > 1) {
		NSUInteger cursor = [self firstIndex];
		BOOL first = YES;

		for (;;) {
			NSRange span = [self ost_rangeGreaterThanOrEqualToIndex:cursor];

			if (span.length == 0) {
				break;
			}

			if (!first) {
				hasMultiple = YES;
				break;
			}

			cursor = span.location + span.length;
			first = NO;
		}
	}

	return hasMultiple;
}


@end
