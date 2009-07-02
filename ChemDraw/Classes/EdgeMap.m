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
