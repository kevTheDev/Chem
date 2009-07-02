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
	Node *node;
}

@end

@implementation NodeMapTest

- (void) setUp {
	nodeMap = [[NodeMap alloc] init];
	node = [[Node alloc] initWithXCoord:10.0 yCoord:15.0];
}

- (void) testInit {
	STAssertTrue([nodeMap isEmpty], nil);
}

- (void) testAddNode {
	[nodeMap addNode:node];
	STAssertFalse([nodeMap isEmpty], nil);
	
	int newCount = [nodeMap count];
	STAssertEquals(newCount, 1, nil);
	
	
}

@end
