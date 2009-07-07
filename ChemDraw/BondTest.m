//
//  BondTest.m
//  ChemDraw
//
//  Created by Kevin Edwards on 30/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import <ApplicationServices/ApplicationServices.h>

#import "Bond.h"
#import "Node.h"

@interface BondTest : SenTestCase {
	
	Node *nodeA;
	Node *nodeB;
	
	Bond *bond;
	Bond *reverseBond;
}

@end

@implementation BondTest

- (void) setUp {
	
	nodeA = [[Node alloc] initWithXCoord:10.0 yCoord:14.0];
	nodeB = [[Node alloc] initWithXCoord:50.0 yCoord:40.0];
	
	bond = [[Bond alloc] initWithNodeA:nodeA nodeB:nodeB];
	reverseBond = [[Bond alloc] initWithNodeA:nodeB nodeB:nodeA];
}

- (void) testNodeANotNil {	
	STAssertNotNil([bond nodeA], nil);	
}

- (void) testNodeBNotNil {	
	STAssertNotNil([bond nodeB], nil);	
}

- (void) testCenterPoint {
	
	Node *centerNode = [bond centerPointNode];
	
	STAssertEquals([centerNode xCoord], 30.0f, nil);
	STAssertEquals([centerNode yCoord], 27.0f, nil);
	
	// test for when bond nodes are reversed - i.e. make sure we don't get negative values skewing things
	Node *reverseCenterNode = [reverseBond centerPointNode];
	STAssertEquals([reverseCenterNode xCoord], 30.0f, nil);
	STAssertEquals([reverseCenterNode yCoord], 27.0f, nil);
}

- (void) testHighlight {
	[bond highlight];
	STAssertTrue([bond unconfirmedHighlight], nil);	
}

- (void) testIsHighlighted {
	STAssertFalse([bond isHighlighted], nil);
	
	[bond highlight];
	STAssertTrue([bond isHighlighted], nil);
}

- (void) testSelect {
	STAssertFalse([bond confirmedHighlight], nil);	
	[bond select];	
	STAssertTrue([bond confirmedHighlight], nil);
}

- (void) testSelectResetsHighlight {
	[bond highlight];
	[bond select];
	STAssertFalse([bond isHighlighted], nil);
}

- (void) testIsSelected {
	STAssertFalse([bond isSelected], nil);
	[bond select];
	STAssertTrue([bond isSelected], nil);
}

// tests that an bond cannot be equal to an object of another class
- (void) testIsNotEqualToNonBond {
	NSString *testString = @"test string";	
	STAssertFalse([bond isEqual:testString], nil);
}

- (void) testIsEqualIfBothNodesEqual {
	STAssertTrue([bond isEqual:reverseBond], nil);
}

- (void) testHashIsProductOfNodeHashes {
	
	int nodeAHash = [nodeA hash];
	int nodeBHash = [nodeB hash];
	
	NSString *expectedHashString = [NSString stringWithFormat:@"%d%d", nodeAHash, nodeBHash];
	
	int bondHash = [bond hash];

	STAssertEquals(bondHash, [expectedHashString intValue], nil);
	
}


// test whether one of the nodes belonging to this bond reside to the north of the node passed in

// where our bonds nodes have y values of 14.0 and 40.0
// where our bonds nodes have x values of 10.0 and 50.0
- (void) testHasNodeToNorthOfNode {
	Node *northNode = [[Node alloc] initWithXCoord:10.0 yCoord:5.0];	
	STAssertFalse([bond hasNodeToNorthOfNode:northNode], nil);
	
	Node *middleNode = [[Node alloc] initWithXCoord:10.0 yCoord:30.0];
	STAssertTrue([bond hasNodeToNorthOfNode:middleNode], nil);
}

// test whether one of the nodes belonging to this bond reside to the north of the node passed in
- (void) testHasNodeToSouthOfNode {
	Node *southNode = [[Node alloc] initWithXCoord:10.0 yCoord:45.0];	
	STAssertFalse([bond hasNodeToSouthOfNode:southNode], nil);
	
	Node *middleNode = [[Node alloc] initWithXCoord:10.0 yCoord:30.0];
	STAssertTrue([bond hasNodeToSouthOfNode:middleNode], nil);
}

- (void) tearDown {
	
	[nodeB release];
	[nodeA release];
	[bond release];
	[reverseBond release];
	
}


@end
	