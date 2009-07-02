//
//  EdgeMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 30/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Edge.h"

@interface EdgeMap : NSObject {
	NSMutableArray *edges;
	NSMutableArray *highlightedEdges;
	NSMutableArray *selectedEdges;
}

- (BOOL) isEmpty;
- (void) addEdge:(Edge *)edge;
- (NSUInteger) count;


- (Edge *) closestEdgeToPoint:(CGPoint)point;

- (NSUInteger)indexOfObject:(id)anObject;
- (id)objectAtIndex:(NSUInteger)index;


- (void) highlightEdgeAtIndex:(NSUInteger)index;
- (void) highlightEdge:(Edge *)edge;
- (NSUInteger)highlightedEdgesCount;

- (void) selectEdgeAtIndex:(NSUInteger)index;
- (void) selectEdge:(Edge *)edge;
- (NSUInteger)selectedEdgesCount;


@end
