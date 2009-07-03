//
//  BondMapTest.m
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

#import "BondMap.h"
#import "Bond.h"
#import "NodeMap.h"
#import "Node.h"

@interface BondMapTest : SenTestCase {	
	BondMap *bondMap;
	
	Bond *bondOne;
	Node *nodeOneA;
	Node *nodeOneB;
	
	Bond *bondTwo;	
	Node *nodeTwoA;
	Node *nodeTwoB;

	CGPoint point;
}

@end

@implementation BondMapTest

- (void) setUp {
	bondMap = [[BondMap alloc] init];
	
	
	nodeOneA = [[Node alloc] initWithXCoord:10.0 yCoord:90.0];
	nodeOneB = [[Node alloc] initWithXCoord:90.0 yCoord:20.0];
	bondOne = [[Bond alloc] initWithNodeA:nodeOneA nodeB:nodeOneB];
	
	nodeTwoA = [[Node alloc] initWithXCoord:10.0 yCoord:60.0];
	nodeTwoB = [[Node alloc] initWithXCoord:90.0 yCoord:90.0];
	bondTwo = [[Bond alloc] initWithNodeA:nodeTwoA nodeB:nodeTwoB];
	
	
	point = CGPointMake(30.0, 100.0);
}

- (void) testInit {
	STAssertTrue([bondMap isEmpty], nil);
}

- (void) testAddBond {
	[bondMap addBond:bondOne];
	[bondMap addBond:bondTwo];
	
	int newCount = [bondMap count];
	STAssertEquals(newCount, 2, nil);	
}

- (void) testClosestCenterPointToPoint {
	
	Node *centerNodeOne = [bondOne centerPointNode];
	Node *centerNodeTwo = [bondTwo centerPointNode];
	
	NodeMap *nodeMap = [[NodeMap alloc] init];
	[nodeMap addNode:centerNodeOne];
	[nodeMap addNode:centerNodeTwo];
	
	Node *closestNode = [nodeMap closestNodeToPoint:point];
	
	STAssertEqualObjects(closestNode, centerNodeTwo, nil);
}

- (void) testClosestBondToPoint {
	[bondMap addBond:bondOne];
	[bondMap addBond:bondTwo];
	
	Bond *closestBond = [bondMap closestBondToPoint:point];
	
	STAssertEqualObjects(closestBond, bondTwo, nil);
}

- (void) testHighlightBondAtIndex {
	[bondMap addBond:bondOne];
	[bondMap addBond:bondTwo];
	
	[bondMap highlightBondAtIndex:0];
	
	Bond *highlightedBond = [bondMap objectAtIndex:0];
	Bond *otherBond = [bondMap objectAtIndex:1];
	
	STAssertTrue([highlightedBond isHighlighted], nil);
	STAssertFalse([otherBond isHighlighted], nil);
}

- (void) testHighlightedBondsCount {
	[bondMap addBond:bondOne];
	[bondMap addBond:bondTwo];
	
	[bondMap highlightBondAtIndex:1];
	
	int newHighlightedCount = [bondMap highlightedBondsCount];
	
	STAssertEquals(newHighlightedCount, 1, nil);
}

- (void) testSelectBondAtIndex {
	[bondMap addBond:bondOne];
	[bondMap addBond:bondTwo];
	
	[bondMap selectBondAtIndex:1];
	
	Node *selectedNode = [bondMap objectAtIndex:1];
	
	STAssertTrue([selectedNode isSelected], nil);
}

- (void) testSelectedBondsCount {
	[bondMap addBond:bondOne];
	[bondMap addBond:bondTwo];	
	[bondMap selectBondAtIndex:1];
	
	int newSelectedCount = [bondMap selectedBondsCount];
	
	STAssertEquals(newSelectedCount, 1, nil);
}

- (void) testSelectBondAtIndexResetsHighlightedNodesArray {
	[bondMap addBond:bondOne];
	[bondMap addBond:bondTwo];
	
	[bondMap highlightBondAtIndex:1];
	[bondMap selectBondAtIndex:1];
	
	int newHighlightedCount = [bondMap highlightedBondsCount];
	
	STAssertEquals(newHighlightedCount, 0, nil);
}

@end
