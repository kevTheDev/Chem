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
		
		actionMap = [[ActionMap alloc] init];
		nodeMap = [[NodeMap alloc] init];
        bondMap = [[BondMap alloc] init];
		
		Node *firstNode = [[Node alloc] initWithXCoord:100 yCoord:200];
		Node *secondNode = [[Node alloc] initWithXCoord:200 yCoord:200];
		
		Bond *bond = [[Bond alloc] initWithNodeA:firstNode nodeB:secondNode];
		
		[self addBond:bond];
		[self addNode:firstNode];
		[self addNode:secondNode];
    }
	
    return self;
	
}

- (NSUInteger)nodesCount {
	return [nodeMap count];
}

- (NSUInteger)bondsCount {
	return [bondMap count];
}

- (NSUInteger) indexOfNode:(Node *)node {
	return [nodeMap indexOfObject:node];
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

- (void) clearSelectedNodes {
	[nodeMap clearSelectedNodes];
}

- (void) clearSelectedBonds {
	[bondMap clearSelectedBonds];
}

- (void) clearSelectedObjects {
	[bondMap clearSelectedBonds];
	[nodeMap clearSelectedNodes];
}

- (void) clearHighlightedObjects {
	[bondMap clearHighlightedBonds];
	[nodeMap clearHighlightedNodes];
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
	AddNodeAction *action = [[AddNodeAction alloc] init];
	[actionMap addAction:action];
}

- (void) addBond:(Bond *)bond {
	[bondMap addBond:bond];
	AddBondAction *action = [[AddBondAction alloc] init];
	[actionMap addAction:action];
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

- (Node *) currentlySelectedNode {
	return [nodeMap currentlySelectedNode];
}

- (Bond *) currentlySelectedBond {
	return [bondMap currentlySelectedBond];
}

- (NSObject *) currentlySelectedObject {
	Bond *selectedBond = [self currentlySelectedBond];
	Node *selectedNode = [self currentlySelectedNode];
	
	if(selectedBond != NULL) {
		return selectedBond;
	}
	else if(selectedNode != NULL) {
		return selectedNode;
	}
	else {
		return NULL;
	}
}

- (NSObject *) currentlyHighlightedObject {
	Bond *highlightedBond = [bondMap currentlyHighlightedBond];
	Node *highlightedNode = [nodeMap currentlyHighlightedNode];
	
	if(highlightedBond != NULL) {
		return highlightedBond;
	}
	else if(highlightedNode != NULL) {
		return highlightedNode;
	}
	else {
		return NULL;
	}
	
}

- (void) renderWithContext:(CGContextRef)ctx {
	[bondMap renderWithContext:ctx];
	[nodeMap renderWithContext:ctx];
}

- (void) undoLastAction {
	Action *lastAction = [actionMap lastAction];
	
	if([lastAction isKindOfClass:[AddNodeAction class]]) {
		
		NSLog(@"LAST ACTION WAS A NODE ACTION");		
		[nodeMap removeLastNode];
	}
	else {
		NSLog(@"LAST ACTION WAS A BOND ACTION");
		[bondMap removeLastBond];
		//[nodeMap removeLastNode];		
	}
	
	[actionMap removeLastAction];
		
}

- (void)dealloc {
	[actionMap release];
	[nodeMap release];
	[bondMap release];
    [super dealloc];
}


@end
