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
	
	nodeOne = [[Node alloc] initWithXCoord:10.0 yCoord:90.0];
	nodeTwo = [[Node alloc] initWithXCoord:90.0 yCoord:20.0];
	
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
	
	STAssertEqualObjects(closestNode, nodeOne, nil);
}

@end
