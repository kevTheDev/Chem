//
//  EdgeMapTest.m
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

#import "EdgeMap.h"
#import "Edge.h"
#import "NodeMap.h"
#import "Node.h"

@interface EdgeMapTest : SenTestCase {	
	EdgeMap *edgeMap;
	
	Edge *edgeOne;
	Node *nodeOneA;
	Node *nodeOneB;
	
	Edge *edgeTwo;	
	Node *nodeTwoA;
	Node *nodeTwoB;

	CGPoint point;
}

@end

@implementation EdgeMapTest

- (void) setUp {
	edgeMap = [[EdgeMap alloc] init];
	
	
	nodeOneA = [[Node alloc] initWithXCoord:10.0 yCoord:90.0];
	nodeOneB = [[Node alloc] initWithXCoord:90.0 yCoord:20.0];
	edgeOne = [[Edge alloc] initWithNodeA:nodeOneA nodeB:nodeOneB];
	
	nodeTwoA = [[Node alloc] initWithXCoord:10.0 yCoord:60.0];
	nodeTwoB = [[Node alloc] initWithXCoord:90.0 yCoord:90.0];
	edgeTwo = [[Edge alloc] initWithNodeA:nodeTwoA nodeB:nodeTwoB];
	
	
	point = CGPointMake(30.0, 100.0);
}

- (void) testInit {
	STAssertTrue([edgeMap isEmpty], nil);
}

- (void) testAddEdge {
	[edgeMap addEdge:edgeOne];
	[edgeMap addEdge:edgeTwo];
	
	int newCount = [edgeMap count];
	STAssertEquals(newCount, 2, nil);	
}

- (void) testClosestCenterPointToPoint {
	
	Node *centerNodeOne = [edgeOne centerNode];
	Node *centerNodeTwo = [edgeTwo centerNode];
	
	NodeMap *nodeMap = [[NodeMap alloc] init];
	[nodeMap addNode:centerNodeOne];
	[nodeMap addNode:centerNodeTwo];
	
	Node *closestNode = [nodeMap closestNodeToPoint:point];
	
	STAssertEqualObjects(closestNode, centerNodeTwo, nil);
}

- (void) testClosestEdgeToPoint {
	[edgeMap addEdge:edgeOne];
	[edgeMap addEdge:edgeTwo];
	
	Edge *closestEdge = [edgeMap closestEdgeToPoint:point];
	
	STAssertEqualObjects(closestEdge, edgeTwo, nil);
}

@end
