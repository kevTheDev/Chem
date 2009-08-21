//
//  ObjectMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ObjectMap.h"



#import "NodeMap.h"
#import "BondMap.h"
#import "ActionMap.h"
#import "Node.h"
#import "Bond.h"
#import "PotentialBond.h"

#import "Action.h"
#import "AddNodeAction.h"
#import "AddBondAction.h"
#import "SingleBondAction.h"
#import "DoubleBondAction.h"
#import "TripleBondAction.h"

@implementation ObjectMap

@synthesize nodeMap;
@synthesize bondMap;

# define BOND_LENGTH 100
 

- (ObjectMap *) init {
	
	self = [super init];
	
    if ( self ) {
		
		actionMap = [[ActionMap alloc] init];
		nodeMap = [[NodeMap alloc] init];
        bondMap = [[BondMap alloc] init];
		
		Node *firstNode = [[Node alloc] initWithXCoord:320 yCoord:480];
		Node *secondNode = [[Node alloc] initWithXCoord:420 yCoord:480];
		
		Bond *bond = [[Bond alloc] initWithNodeA:firstNode nodeB:secondNode];
		
		[self addBond:bond];
		[self addNode:firstNode];
		[self addNode:secondNode];
    }
	
    return self;
	
}

- (void)dealloc {
	[actionMap release];
	[nodeMap release];
	[bondMap release];
    [super dealloc];
}


- (void) manipulateBond:(Bond *)bond {

	if([bond isSingle]) {
		[bond makeDouble];
		Action *action = [[DoubleBondAction alloc] initWithBond:bond];
		[actionMap addAction:action];
	}
	else if([bond isDouble]) {
		[bond makeTriple];
		Action *action = [[TripleBondAction alloc] initWithBond:bond];
		[actionMap addAction:action];
	}
	else {
		[bond makeSingle];
		SingleBondAction *action = [[SingleBondAction alloc] initWithBond:bond];
		[actionMap addAction:action];
	}
		
	[self clearSelectedBonds];
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

- (NSUInteger)selectedBondsCount {
	return [bondMap selectedBondsCount];
}



- (NSUInteger)highlightedBondsCount {
	return [bondMap highlightedBondsCount];
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

- (BOOL) isEmpty {
	return ([nodeMap count] == 0) && ([bondMap count] == 0);
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

// potential bonds will all belong to the closest node

- (void) highlightClosestPotentialBondToPoint:(CGPoint)point {
	NSObject *currentlySelectedObject = [self currentlySelectedObject];
	
	if(![currentlySelectedObject isKindOfClass:[Node class]]) {
		return;
	}
	
	Node *currentlySelectedNode = (Node *) currentlySelectedObject;
	[currentlySelectedNode highlightClosestPotentialBondToPoint:point];
}

- (PotentialBond *)currentlyHighlightedPotentialBond {
	Node *currentlySelectedNode = (Node *) [self currentlySelectedObject];
	
	return [currentlySelectedNode currentlyHighlightedPotentialBond];
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
	
	// dont let the user remove the first bond
	if([actionMap count] > 3) {
	
		Action *lastAction = [actionMap lastAction];
	
		if([lastAction isKindOfClass:[AddNodeAction class]]) {
		
			NSLog(@"LAST ACTION WAS A NODE ACTION");		
			[nodeMap removeLastNode];
		}
		else if([lastAction isKindOfClass:[AddBondAction class]]) {
			NSLog(@"LAST ACTION WAS A BOND ACTION");
			[bondMap removeLastBond];
		}
		else if([lastAction isKindOfClass:[SingleBondAction class]]) {
			[(SingleBondAction *) lastAction undo];
		}
		else if([lastAction isKindOfClass:[DoubleBondAction class]]) {
			[(DoubleBondAction *) lastAction undo];
		}
		else if([lastAction isKindOfClass:[TripleBondAction class]]) {
			[(TripleBondAction *) lastAction undo];
		}
		
	
		[actionMap removeLastAction];
	}
		
}

- (void) renderPotentialBondMap {
	NSObject *currentlySelectedObject = [self currentlySelectedObject];
	
	if(![currentlySelectedObject isKindOfClass:[Node class]]) {
		return;
	}
	
	Node *selectedNode = (Node *) currentlySelectedObject;
	[selectedNode setDisplayPotentialBondMap:YES];
	 
	
}

- (void) drawPotentialRings:(NSInteger)ringSize {
	

}



@end
