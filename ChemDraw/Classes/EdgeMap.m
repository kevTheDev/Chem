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
    }
	
    return self;
	
}

- (NSUInteger)selectedEdgesCount {
	int count = 0;
	
	for(Edge *edge in edges) {
		if([edge isSelected]) {
			count++;
		}
	}
	
	return count;
}

- (void) selectEdge:(Edge *)edge {
	NSUInteger edgeIndex = [edges indexOfObject:edge];
	[self selectEdgeAtIndex:edgeIndex];
}

- (void) selectEdgeAtIndex:(NSUInteger)index {
	Edge *edge = [edges objectAtIndex:index];
	[edge select];
	return;
}

- (NSUInteger)highlightedEdgesCount {
	int count = 0;
	
	for(Edge *edge in edges) {
		if([edge isHighlighted]) {
			count++;
		}
	}
	
	return count;
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

	CGPoint edgeCenterPoint;
	
	int closestNodeIndex = 0;
	float currentShortestDistance = 0.0;
	
	for(int i=0; i<[edges count]; i++) {		
		edgeCenterPoint = [[edges objectAtIndex:i] centerPoint];
		
		float xDistance = abs(point.x - edgeCenterPoint.x);
		float yDistance = abs(point.y - edgeCenterPoint.y);
		
		float newDistance = xDistance + yDistance;
		
		if(currentShortestDistance == 0) {
			currentShortestDistance = newDistance;
		}
		else {
			
			if(newDistance < currentShortestDistance) {
				currentShortestDistance = newDistance;
				closestNodeIndex = i;
			}
			
		}
		
	}

		
	return [edges objectAtIndex:closestNodeIndex];
	
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
	return [edges countByEnumeratingWithState:state objects:stackbuf count:len];
}

- (void) renderWithContext:(CGContextRef)ctx {
	for (Edge *edge in edges) {
		[edge renderWithContext:ctx];
	}
}

- (void)dealloc {
	[edges release];
    [super dealloc];
}

@end
