//
//  ObjectMapTest.m
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

#import "ObjectMap.h"
#import "BondMap.h"
#import "Bond.h"
#import "NodeMap.h"
#import "Node.h"

@interface ObjectMapTest : SenTestCase {
	
	ObjectMap *objectMap;
		
	Bond *bondOne;
	Node *nodeOneA;
	Node *nodeOneB;
	
	Bond *bondTwo;	
	Node *nodeTwoA;
	Node *nodeTwoB;
	
	CGPoint point;
}

@end

@implementation ObjectMapTest

- (void) setUp {
	objectMap = [[ObjectMap alloc] init];
	
	
	nodeOneA = [[Node alloc] initWithXCoord:10.0 yCoord:90.0];
	nodeOneB = [[Node alloc] initWithXCoord:90.0 yCoord:20.0];
	bondOne = [[Bond alloc] initWithNodeA:nodeOneA nodeB:nodeOneB];
	
	nodeTwoA = [[Node alloc] initWithXCoord:10.0 yCoord:60.0];
	nodeTwoB = [[Node alloc] initWithXCoord:90.0 yCoord:90.0];
	bondTwo = [[Bond alloc] initWithNodeA:nodeTwoA nodeB:nodeTwoB];
	
	
	point = CGPointMake(30.0, 100.0);
}

- (void) testInit {
	STAssertTrue([objectMap isEmpty], nil);
}

- (void) testAddBond {
	[objectMap addBond:bondOne];	
	STAssertFalse([objectMap isEmpty], nil);	
}

- (void) testAddNode {
	[objectMap addNode:nodeOneB];	
	STAssertFalse([objectMap isEmpty], nil);
}

- (void) testCount {
	[objectMap addBond:bondOne];
	[objectMap addNode:nodeOneB];
	
	int newCount = [objectMap count];
	STAssertEquals(newCount, 2, nil);
}

- (void) testClosestNodeToPoint {
	[objectMap addNode:nodeOneA];
	[objectMap addNode:nodeOneB];
	
	[objectMap addNode:nodeTwoA];
	[objectMap addNode:nodeTwoB];
	
	Node *closestNode = [objectMap closestNodeToPoint:point];
	
	STAssertEqualObjects(closestNode, nodeOneA, nil);
}

- (void) testClosestBondToPoint {
	[objectMap addBond:bondOne];
	[objectMap addBond:bondTwo];
	
	Bond *closestBond = [objectMap closestBondToPoint:point];
	STAssertEqualObjects(closestBond, bondTwo, nil);	
}

- (void) testClosestObjectToPoint {
	[objectMap addNode:nodeOneA];
	[objectMap addNode:nodeOneB];
	[objectMap addBond:bondOne];
	
	[objectMap addNode:nodeTwoA];
	[objectMap addNode:nodeTwoB];
	[objectMap addBond:bondTwo];
	
	NSObject *closestObject = [objectMap closestObjectToPoint:point];
	
	STAssertEqualObjects(closestObject, nodeOneA, nil);
}

- (void) testHighlightNode {
	[objectMap addNode:nodeOneA];
	[objectMap addNode:nodeOneB];
	
	[objectMap highlightNode:nodeOneA];
	
	Node *highlightedNode = [objectMap nodeAtIndex:0];
	
	STAssertTrue([highlightedNode isHighlighted], nil);
}

- (void) testHighlightedNodesCount {
	[objectMap addNode:nodeOneA];
	[objectMap addNode:nodeOneB];
	
	[objectMap highlightNode:nodeOneA];
	
	int newHighlightedCount = [objectMap highlightedNodesCount];
	
	STAssertEquals(newHighlightedCount, 1, nil);
}



- (void) testSelectedNodesCount {
	[objectMap addNode:nodeOneA];
	[objectMap addNode:nodeOneB];
	
	[objectMap selectNode:nodeOneB];
	
	int newSelectedCount = [objectMap selectedNodesCount];
	
	STAssertEquals(newSelectedCount, 1, nil);
}

- (void) testSelectNodeAtIndexResetsHighlightedNodesArray {
	[objectMap addNode:nodeOneA];
	[objectMap addNode:nodeOneB];
	
	[objectMap highlightNode:nodeOneA];
	[objectMap selectNode:nodeOneA];
	
	int newHighlightedCount = [objectMap highlightedNodesCount];
	
	STAssertEquals(newHighlightedCount, 0, nil);
}

- (void) testHighlightedBondsCount {
	[objectMap addBond:bondOne];
	[objectMap addBond:bondTwo];
	
	[objectMap highlightBond:bondTwo];
	
	int newHighlightedCount = [objectMap highlightedBondsCount];
	
	STAssertEquals(newHighlightedCount, 1, nil);
}

- (void) testSelectedBondsCount {
	[objectMap addBond:bondOne];
	[objectMap addBond:bondTwo];	
	[objectMap selectBond:bondTwo];
	
	int newSelectedCount = [objectMap selectedBondsCount];
	
	STAssertEquals(newSelectedCount, 1, nil);
}

- (void) testSelectBondResetsHighlightedBonds {
	[objectMap addBond:bondOne];
	[objectMap addBond:bondTwo];
	
	[objectMap highlightBond:bondOne];
	[objectMap selectBond:bondOne];
	
	int newHighlightedCount = [objectMap highlightedBondsCount];
	
	STAssertEquals(newHighlightedCount, 0, nil);
}

- (void) testHighlightClosestObjectToPointWithNode {
	[objectMap addNode:nodeOneA];
	[objectMap addNode:nodeOneB];
	[objectMap addBond:bondOne];
	
	[objectMap addNode:nodeTwoA];
	[objectMap addNode:nodeTwoB];
	[objectMap addBond:bondTwo];
	
	[objectMap highlightClosestObjectToPoint:point];

	int newHighlightedCount = [objectMap highlightedNodesCount];
	STAssertEquals(newHighlightedCount, 1, nil);
	
	int newHighlightedBondsCount = [objectMap highlightedBondsCount];
	STAssertEquals(newHighlightedBondsCount, 0, nil);
}

- (void) testHighlightClosestObjectToPointWithBond {
	[objectMap addBond:bondOne];
	
	[objectMap addNode:nodeTwoA];
	[objectMap addNode:nodeTwoB];
	[objectMap addBond:bondTwo];
	
	[objectMap highlightClosestObjectToPoint:point];
	
	int newHighlightedCount = [objectMap highlightedBondsCount];
	STAssertEquals(newHighlightedCount, 1, nil);
	
	int newHighlightedBondsCount = [objectMap highlightedNodesCount];
	STAssertEquals(newHighlightedBondsCount, 0, nil);
}

- (void) testSelectClosestObjectToPointWithNode {
	[objectMap addNode:nodeOneA];
	[objectMap addNode:nodeOneB];
	[objectMap addBond:bondOne];
	
	[objectMap addNode:nodeTwoA];
	[objectMap addNode:nodeTwoB];
	[objectMap addBond:bondTwo];
	
	[objectMap selectClosestObjectToPoint:point];
	
	int newSelectedNodesCount = [objectMap selectedNodesCount];
	STAssertEquals(newSelectedNodesCount, 1, nil);
	
	int selectedBondsCount = [objectMap selectedBondsCount];
	STAssertEquals(selectedBondsCount, 0, nil);
}

- (void) testSelectClosestObjectToPointWithBond {
	[objectMap addBond:bondOne];
	
	[objectMap addNode:nodeTwoA];
	[objectMap addNode:nodeTwoB];
	[objectMap addBond:bondTwo];
	
	[objectMap selectClosestObjectToPoint:point];
	
	int newSelectedNodesCount = [objectMap selectedNodesCount];
	STAssertEquals(newSelectedNodesCount, 0, nil);
	
	int selectedBondsCount = [objectMap selectedBondsCount];
	STAssertEquals(selectedBondsCount, 1, nil);
}


@end
