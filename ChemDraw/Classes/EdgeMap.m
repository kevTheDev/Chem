//
//  EdgeMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 30/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EdgeMap.h"
#import "NodeMap.h"

@implementation EdgeMap


- (EdgeMap *) init {
	
	self = [super init];
	
    if ( self ) {
        edges = [[NSMutableArray alloc] initWithCapacity:5];
		highlightedEdges = [[NSMutableArray alloc] initWithCapacity:5];
		selectedEdges = [[NSMutableArray alloc] initWithCapacity:5];
    }
	
    return self;
	
}

- (NSUInteger)selectedEdgesCount {
	return [selectedEdges count];
}

- (void) selectEdge:(Edge *)edge {
	NSUInteger edgeIndex = [edges indexOfObject:edge];
	[self selectEdgeAtIndex:edgeIndex];
}

- (void) selectEdgeAtIndex:(NSUInteger)index {
	Edge *edge = [edges objectAtIndex:index];
	[edge select];
	
	[selectedEdges addObject:edge];	
	[highlightedEdges removeAllObjects];
	return;
}

- (NSUInteger)highlightedEdgesCount {
	return [highlightedEdges count];
}

- (NSUInteger)indexOfObject:(id)anObject {
	return [edges indexOfObject:anObject];
}

- (id)objectAtIndex:(NSUInteger)index {
	return [edges objectAtIndex:index];
}

- (void) highlightEdgeAtIndex:(NSUInteger)index {
	Edge *edge = [edges objectAtIndex:index];
	[edge highlight];
	[highlightedEdges addObject:edge];	
	return;
}

- (void) highlightEdge:(Edge *)edge {
	NSUInteger edgeIndex = [edges indexOfObject:edge];
	NSLog(@"EDGE MAP INDEX: %d", edgeIndex);
	[self highlightEdgeAtIndex:edgeIndex];
}

- (NSUInteger) count {
	return [edges count];
}

- (BOOL) isEmpty {
	return [edges count] == 0;	
}

- (void) addEdge:(Edge *)edge {
	[edges addObject:edge];
}

// returns the closest edge in the map to a point
- (Edge *) closestEdgeToPoint:(CGPoint)point {
	
	NodeMap *centerNodes = [[NodeMap alloc] init];
	
	for(int i=0; i<[edges count]; i++)
	{				
		Node *edgeCenterNode = [[edges objectAtIndex:i] centerNode];
		[centerNodes addNode:edgeCenterNode];		
	}
	
	Node *closestCenterNode = [centerNodes closestNodeToPoint:point];
	int closestEdgeIndex  = [centerNodes indexOfObject:closestCenterNode];
	
	[centerNodes release];
		
	return [edges objectAtIndex:closestEdgeIndex];
	
}

- (void)dealloc {
	[edges release];
    [super dealloc];
}

@end
