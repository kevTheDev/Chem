//
//  ObjectMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ObjectMap.h"


@implementation ObjectMap

- (ObjectMap *) init {
	
	self = [super init];
	
    if ( self ) {
		nodes = [[NodeMap alloc] init];
        edges = [[EdgeMap alloc] init];
    }
	
    return self;
	
}

- (BOOL) isEmpty {
	return ([nodes count] == 0) && ([edges count] == 0);
}

- (NSUInteger) count {
	return [edges count] + [nodes count];
}

- (void) addNode:(Node *)node {
	[nodes addNode:node];
}

- (void) addEdge:(Edge *)edge {
	[edges addEdge:edge];
}

- (NSObject *) closestObjectToPoint:(CGPoint)point {
	Node *closestNode = [nodes closestNodeToPoint:point];
	Edge *closestEdge = [edges closestEdgeToPoint:point];
	
	// find closest out of closest edge and node
	Node *closestEdgeCenterPoint = [closestEdge centerNode];
	
	float edgeXDistance = abs(point.x - [closestEdgeCenterPoint xCoord]);
	float edgeYDistance = abs(point.y - [closestEdgeCenterPoint yCoord]);
	
	float edgeDistance = edgeXDistance + edgeYDistance;
	
	float nodeXDistance = abs(point.x - [closestNode xCoord]);
	float nodeYDistance = abs(point.y - [closestNode yCoord]);
	
	float nodeDistance = nodeXDistance + nodeYDistance;
	
	if(nodeDistance > edgeDistance) {
		return closestEdge;
	}
	else {
		return closestNode;
	}

}

- (void)dealloc {
	[nodes release];
	[edges release];
    [super dealloc];
}


@end
