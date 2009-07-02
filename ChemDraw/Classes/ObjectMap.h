//
//  ObjectMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NodeMap.h"
#import "EdgeMap.h"

@interface ObjectMap : NSObject {
	NodeMap *nodes;
	EdgeMap *edges;
}

- (BOOL) isEmpty;
- (NSUInteger) count;

- (void) addNode:(Node *)node;
- (void) addEdge:(Edge *)edge;

- (NSObject *) closestObjectToPoint:(CGPoint)point;

@end
