//
//  EntityChild.h
//  Ordered Set Test
//
//  Created by Basil Shkara on 25/09/2013.
//  Copyright (c) 2013 Basil Shkara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EntityParent;

@interface EntityChild : NSManagedObject

@property (nonatomic, retain) EntityParent *parent;

@end
