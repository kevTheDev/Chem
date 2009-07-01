//
//  EdgeTest.m
//  ChemDraw
//
//  Created by Kevin Edwards on 30/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

#import "Edge.h"

@interface EdgeTest : SenTestCase {
	
	Node *nodeA;
	Node *nodeB;
	
	Edge *edge;
	Edge *reverseEdge;
}

@end

@implementation EdgeTest

- (void) setUp {
	
	nodeA = [[Node alloc] initWithXCoord:10.0 yCoord:14.0];
	nodeB = [[Node alloc] initWithXCoord:50.0 yCoord:40.0];
	
	edge = [[Edge alloc] initWithNodeA:nodeA nodeB:nodeB];
	reverseEdge = [[Edge alloc] initWithNodeA:nodeB nodeB:nodeA];
}

- (void) testNodeANotNil {	
	STAssertNotNil([edge nodeA], nil);	
}

- (void) testNodeBNotNil {	
	STAssertNotNil([edge nodeB], nil);	
}

- (void) testCenterPoint {
	
	Node *centerNode = [edge centerNode];
	
	STAssertEquals([centerNode xCoord], 30.0f, nil);
	STAssertEquals([centerNode yCoord], 27.0f, nil);
	
	// test for when edge nodes are reversed - i.e. make sure we don't get negative values skewing things
	Node *reverseCenterNode = [reverseEdge centerNode];
	STAssertEquals([reverseCenterNode xCoord], 30.0f, nil);
	STAssertEquals([reverseCenterNode yCoord], 27.0f, nil);
}

- (void) testHighlight {
	[edge highlight];
	STAssertTrue([edge unconfirmedHighlight], nil);	
}

- (void) testIsHighlighted {
	STAssertFalse([edge isHighlighted], nil);
	
	[edge highlight];
	STAssertTrue([edge isHighlighted], nil);
}

- (void) testConfirmSelection {
	STAssertFalse([edge confirmedHighlight], nil);	
	[edge confirmSelection];	
	STAssertTrue([edge confirmedHighlight], nil);
}

- (void) testConfirmSelectionResetsHighlight {
	[edge highlight];
	[edge confirmSelection];
	STAssertFalse([edge isHighlighted], nil);
}

- (void) testIsSelected {
	STAssertFalse([edge isSelected], nil);
	[edge confirmSelection];
	STAssertTrue([edge isSelected], nil);
}



- (void) tearDown {
	
	[nodeB release];
	[nodeA release];
	[edge release];
	[reverseEdge release];
	
}


@end
