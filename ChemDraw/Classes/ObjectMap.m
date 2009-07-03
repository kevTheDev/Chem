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
@synthesize bondMap;

- (ObjectMap *) init {
	
	self = [super init];
	
    if ( self ) {
		nodeMap = [[NodeMap alloc] init];
        bondMap = [[BondMap alloc] init];
    }
	
    return self;
	
}



- (NSUInteger)bondsCount {
	return [bondMap count];
}

- (id)nodeAtIndex:(NSUInteger)index {
	return [nodeMap objectAtIndex:index];
}

- (id)bondAtIndex:(NSUInteger)index {
	return [bondMap objectAtIndex:index];
}

- (void) selectBond:(Bond *)bond {
	int bondMapIndex = [bondMap indexOfObject:bond];
	[bondMap selectBondAtIndex:bondMapIndex];
}

- (NSUInteger)selectedBondsCount {
	return [bondMap selectedBondsCount];
}

- (void) highlightBond:(Bond *)bond {
	int bondMapIndex = [bondMap indexOfObject:bond];
	[bondMap highlightBondAtIndex:bondMapIndex];
}

- (NSUInteger)highlightedBondsCount {
	return [bondMap highlightedBondsCount];
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
	return ([nodeMap count] == 0) && ([bondMap count] == 0);
}

- (NSUInteger) count {
	return [bondMap count] + [nodeMap count];
}

- (void) addNode:(Node *)node {
	[nodeMap addNode:node];
}

- (void) addBond:(Bond *)bond {
	[bondMap addBond:bond];
}

- (Node *) closestNodeToPoint:(CGPoint)point {
	return [nodeMap closestNodeToPoint:point];
}

- (Bond *) closestBondToPoint:(CGPoint)point {
	return [bondMap closestBondToPoint:point];
}

- (NSObject *) closestObjectToPoint:(CGPoint)point {
	
	Node *closestNode = [nodeMap closestNodeToPoint:point];
	Bond *closestBond = [bondMap closestBondToPoint:point];

	
	CGPoint closestBondCenterPoint = [closestBond centerPoint];
	
	float bondXDistance = abs(point.x - closestBondCenterPoint.x);
	float bondYDistance = abs(point.y - closestBondCenterPoint.y);

	float bondDistance = bondXDistance + bondYDistance;
	
	
	float nodeXDistance = abs(point.x - [closestNode xCoord]);
	float nodeYDistance = abs(point.y - [closestNode yCoord]);
		
	float nodeDistance = nodeXDistance + nodeYDistance;
	
	if(nodeDistance > bondDistance) {
		return closestBond;
	}
	else {
		return closestNode;
	}

}

- (void) highlightClosestObjectToPoint:(CGPoint)point {
	NSObject *closestObject = [self closestObjectToPoint:point];
	
	if([closestObject isKindOfClass:[Node class]]) {
		
		Node *node = (Node *) closestObject;
		[nodeMap highlightNode:node];
	}	
	else {
		Bond *bond = (Bond *) closestObject;
		[bondMap highlightBond:bond];
	}

}

- (void) selectClosestObjectToPoint:(CGPoint)point {
	NSObject *closestObject = [self closestObjectToPoint:point];
		
	if([closestObject isKindOfClass:[Node class]]) {
		
		Node *node = (Node *) closestObject;
		[nodeMap selectNode:node];
	}	
	else {
		Bond *bond = (Bond *) closestObject;
		[bondMap selectBond:bond];		
	}
	
}

- (Bond *) currentlySelectedBond {
	return [bondMap currentlySelectedBond];
}

- (void) renderWithContext:(CGContextRef)ctx {
	[nodeMap renderWithContext:ctx];
	[bondMap renderWithContext:ctx];
}

- (void)dealloc {
	[nodeMap release];
	[bondMap release];
    [super dealloc];
}


@end
