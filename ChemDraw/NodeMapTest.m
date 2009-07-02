//
//  NodeMapTest.m
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

#import "NodeMap.h"
#import "Node.h"

@interface NodeMapTest : SenTestCase {	
	NodeMap *nodeMap;
	
	Node *nodeOne;
	Node *nodeTwo;
	
	CGPoint point;
}

@end

@implementation NodeMapTest

- (void) setUp {
	nodeMap = [[NodeMap alloc] init];
	
	nodeOne = [[Node alloc] initWithXCoord:50.0 yCoord:55.0];
	nodeTwo = [[Node alloc] initWithXCoord:50.0 yCoord:75.0];
	
	point = CGPointMake(30.0, 100.0);
}

- (void) testInit {
	STAssertTrue([nodeMap isEmpty], nil);
}

- (void) testAddNode {
	[nodeMap addNode:nodeOne];
	[nodeMap addNode:nodeTwo];
	
	int newCount = [nodeMap count];
	STAssertEquals(newCount, 2, nil);	
}

- (void) testClosestNodeToPoint {
	[nodeMap addNode:nodeOne];
	[nodeMap addNode:nodeTwo];
	
	Node *closestNode = [nodeMap closestNodeToPoint:point];
	
	STAssertEqualObjects(closestNode, nodeTwo, nil);
}

- (void) testHighlightNodeAtIndex {
	[nodeMap addNode:nodeOne];
	[nodeMap addNode:nodeTwo];
	
	[nodeMap highlightNodeAtIndex:1];
	
	Node *highlightedNode = [nodeMap objectAtIndex:1];
	
	STAssertTrue([highlightedNode isHighlighted], nil);
}

- (void) testHighlightedNodesCount {
	[nodeMap addNode:nodeOne];
	[nodeMap addNode:nodeTwo];
	
	[nodeMap highlightNodeAtIndex:1];
	
	int newHighlightedCount = [nodeMap highlightedNodesCount];
	
	STAssertEquals(newHighlightedCount, 1, nil);
}

- (void) testSelectNodeAtIndex {
	[nodeMap addNode:nodeOne];
	[nodeMap addNode:nodeTwo];
	
	[nodeMap selectNodeAtIndex:1];
	
	Node *selectedNode = [nodeMap objectAtIndex:1];
	
	STAssertTrue([selectedNode isSelected], nil);
}

- (void) testSelectedNodesCount {
	[nodeMap addNode:nodeOne];
	[nodeMap addNode:nodeTwo];
	
	[nodeMap selectNodeAtIndex:1];
	
	int newSelectedCount = [nodeMap selectedNodesCount];
	
	STAssertEquals(newSelectedCount, 1, nil);
}

- (void) testSelectNodeAtIndexResetsHighlightedNodesArray {
	[nodeMap addNode:nodeOne];
	[nodeMap addNode:nodeTwo];
	
	[nodeMap highlightNodeAtIndex:1];
	[nodeMap selectNodeAtIndex:1];
	
	int newHighlightedCount = [nodeMap highlightedNodesCount];
	
	STAssertEquals(newHighlightedCount, 0, nil);
}

@end
