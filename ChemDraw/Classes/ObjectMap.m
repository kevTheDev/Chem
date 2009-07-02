//
//  ObjectMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ObjectMap.h"


@implementation ObjectMap

@synthesize nodeMap;

- (ObjectMap *) init {
	
	self = [super init];
	
    if ( self ) {
		nodeMap = [[NodeMap alloc] init];
        edgeMap = [[EdgeMap alloc] init];
    }
	
    return self;
	
}

- (void) selectNode:(Node *)node {
	int nodeMapIndex = [nodeMap indexOfObject:node];
	[nodeMap selectNodeAtIndex:nodeMapIndex];
}

- (NSUInteger)selectedNodesCount {
	return [nodeMap selectedNodesCount];
}

- (NSUInteger)highlightedNodesCount {
	return [nodeMap highlightedNodesCount];
}

- (void) highlightNode:(Node *)node {
	int nodeMapIndex = [nodeMap indexOfObject:node];
	
	[nodeMap highlightNodeAtIndex:nodeMapIndex];
}

- (BOOL) isEmpty {
	return ([nodeMap count] == 0) && ([edgeMap count] == 0);
}

- (NSUInteger) count {
	return [edgeMap count] + [nodeMap count];
}

- (void) addNode:(Node *)node {
	[nodeMap addNode:node];
}

- (void) addEdge:(Edge *)edge {
	[edgeMap addEdge:edge];
}

- (Node *) closestNodeToPoint:(CGPoint)point {
	return [nodeMap closestNodeToPoint:point];
}

- (Edge *) closestEdgeToPoint:(CGPoint)point {
	return [edgeMap closestEdgeToPoint:point];
}

- (NSObject *) closestObjectToPoint:(CGPoint)point {
	Node *closestNode = [self closestNodeToPoint:point];
	Edge *closestEdge = [edgeMap closestEdgeToPoint:point];
	
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
	[nodeMap release];
	[edgeMap release];
    [super dealloc];
}


@end
