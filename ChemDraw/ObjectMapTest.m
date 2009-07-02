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
#import "EdgeMap.h"
#import "Edge.h"
#import "NodeMap.h"
#import "Node.h"

@interface ObjectMapTest : SenTestCase {
	
	ObjectMap *objectMap;
		
	Edge *edgeOne;
	Node *nodeOneA;
	Node *nodeOneB;
	
	Edge *edgeTwo;	
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
	edgeOne = [[Edge alloc] initWithNodeA:nodeOneA nodeB:nodeOneB];
	
	nodeTwoA = [[Node alloc] initWithXCoord:10.0 yCoord:60.0];
	nodeTwoB = [[Node alloc] initWithXCoord:90.0 yCoord:90.0];
	edgeTwo = [[Edge alloc] initWithNodeA:nodeTwoA nodeB:nodeTwoB];
	
	
	point = CGPointMake(30.0, 100.0);
}

- (void) testInit {
	STAssertTrue([objectMap isEmpty], nil);
}

- (void) testAddEdge {
	[objectMap addEdge:edgeOne];	
	STAssertFalse([objectMap isEmpty], nil);	
}

- (void) testAddNode {
	[objectMap addNode:nodeOneB];	
	STAssertFalse([objectMap isEmpty], nil);
}

- (void) testCount {
	[objectMap addEdge:edgeOne];
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

- (void) testClosestEdgeToPoint {
	[objectMap addEdge:edgeOne];
	[objectMap addEdge:edgeTwo];
	
	Edge *closestEdge = [objectMap closestEdgeToPoint:point];
	STAssertEqualObjects(closestEdge, edgeTwo, nil);	
}

- (void) testClosestObjectToPoint {
	[objectMap addNode:nodeOneA];
	[objectMap addNode:nodeOneB];
	[objectMap addEdge:edgeOne];
	
	[objectMap addNode:nodeTwoA];
	[objectMap addNode:nodeTwoB];
	[objectMap addEdge:edgeTwo];
	
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

- (void) testHighlightedEdgesCount {
	[objectMap addEdge:edgeOne];
	[objectMap addEdge:edgeTwo];
	
	[objectMap highlightEdge:edgeTwo];
	
	int newHighlightedCount = [objectMap highlightedEdgesCount];
	
	STAssertEquals(newHighlightedCount, 1, nil);
}

- (void) testSelectedEdgesCount {
	[objectMap addEdge:edgeOne];
	[objectMap addEdge:edgeTwo];	
	[objectMap selectEdge:edgeTwo];
	
	int newSelectedCount = [objectMap selectedEdgesCount];
	
	STAssertEquals(newSelectedCount, 1, nil);
}

- (void) testSelectEdgeResetsHighlightedEdges {
	[objectMap addEdge:edgeOne];
	[objectMap addEdge:edgeTwo];
	
	[objectMap highlightEdge:edgeOne];
	[objectMap selectEdge:edgeOne];
	
	int newHighlightedCount = [objectMap highlightedEdgesCount];
	
	STAssertEquals(newHighlightedCount, 0, nil);
}

- (void) testHighlightClosestObjectToPointWithNode {
	[objectMap addNode:nodeOneA];
	[objectMap addNode:nodeOneB];
	[objectMap addEdge:edgeOne];
	
	[objectMap addNode:nodeTwoA];
	[objectMap addNode:nodeTwoB];
	[objectMap addEdge:edgeTwo];
	
	[objectMap highlightClosestObjectToPoint:point];

	int newHighlightedCount = [objectMap highlightedNodesCount];
	STAssertEquals(newHighlightedCount, 1, nil);
	
	int newHighlightedEdgesCount = [objectMap highlightedEdgesCount];
	STAssertEquals(newHighlightedEdgesCount, 0, nil);
}

- (void) testHighlightClosestObjectToPointWithEdge {
	[objectMap addEdge:edgeOne];
	
	[objectMap addNode:nodeTwoA];
	[objectMap addNode:nodeTwoB];
	[objectMap addEdge:edgeTwo];
	
	[objectMap highlightClosestObjectToPoint:point];
	
	int newHighlightedCount = [objectMap highlightedEdgesCount];
	STAssertEquals(newHighlightedCount, 1, nil);
	
	int newHighlightedEdgesCount = [objectMap highlightedNodesCount];
	STAssertEquals(newHighlightedEdgesCount, 0, nil);
}



@end
