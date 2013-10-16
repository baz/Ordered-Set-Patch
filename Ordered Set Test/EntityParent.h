//
//  EntityParent.h
//  Ordered Set Test
//
//  Created by Basil Shkara on 25/09/2013.
//  Copyright (c) 2013 Basil Shkara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EntityChild;

@interface EntityParent : NSManagedObject

@property (nonatomic, retain) NSOrderedSet *children;
@end

@interface EntityParent (CoreDataGeneratedAccessors)

- (void)insertObject:(EntityChild *)value inChildrenAtIndex:(NSUInteger)idx;
- (void)removeObjectFromChildrenAtIndex:(NSUInteger)idx;
- (void)insertChildren:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeChildrenAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInChildrenAtIndex:(NSUInteger)idx withObject:(EntityChild *)value;
- (void)replaceChildrenAtIndexes:(NSIndexSet *)indexes withChildren:(NSArray *)values;
- (void)addChildrenObject:(EntityChild *)value;
- (void)removeChildrenObject:(EntityChild *)value;
- (void)addChildren:(NSOrderedSet *)values;
- (void)removeChildren:(NSOrderedSet *)values;
@end
