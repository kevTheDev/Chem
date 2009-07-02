//
//  NodeMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface NodeMap : NSObject {
	NSMutableArray *nodes;
}

- (BOOL) isEmpty;

- (void) addNode:(Node *)node;
- (NSUInteger) count;

- (Node *) closestNodeToPoint:(CGPoint)point;
- (NSUInteger)indexOfObject:(id)anObject;

@end
