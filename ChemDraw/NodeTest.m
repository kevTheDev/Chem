//
//  NodeTest.m
//  ChemDraw
//
//  Created by Kevin Edwards on 30/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

#import "Node.h"

@interface NodeTest : SenTestCase {	
	Node *node;	
}

@end

@implementation NodeTest

- (void) setUp {
	
	node = [[Node alloc] initWithXCoord:10.0 yCoord:15.0];
	
}

- (void) testHighlight {
	[node highlight];
	STAssertTrue([node unconfirmedHighlight], nil);	
}

- (void) testIsHighlighted {
	STAssertFalse([node isHighlighted], nil);
	
	[node highlight];
	STAssertTrue([node isHighlighted], nil);
}

- (void) testSelect {
	STAssertFalse([node confirmedHighlight], nil);	
	[node select];	
	STAssertTrue([node confirmedHighlight], nil);
}

- (void) testConfirmSelectionResetsHighlight {
	[node highlight];
	[node select];
	STAssertFalse([node isHighlighted], nil);
}

- (void) testIsSelected {
	STAssertFalse([node isSelected], nil);
	[node select];
	STAssertTrue([node isSelected], nil);
}

- (void) testInitXCoord {
	STAssertEquals((float) [node xCoord], 10.0f, nil);
}


- (void) testInitYCoord {
	STAssertEquals((float) [node yCoord], 15.0f, nil);
}

- (void) testHash {
	NSString *expectedHash = @"1015";
	NSUInteger actualHash = [node hash];
	
	int expectedHashInt = [expectedHash intValue];
	int actualHashInt   = (int) actualHash;
	
	STAssertEquals(actualHashInt, expectedHashInt, nil);

}

// tests that a node cannot be equal to an object of a different class
- (void) testIsNotEqualToNonNode {
	NSString *testString = @"test string";
	STAssertFalse([node isEqual:testString], nil);
	[testString release];
}

- (void) testIsNotEqualX {
	Node *unequalNode = [[Node alloc] initWithXCoord:11.0 yCoord:15.0];
	STAssertFalse([node isEqual:unequalNode], nil);
	[unequalNode release];
}

- (void) testIsNotEqualY {
	Node *unequalNode = [[Node alloc] initWithXCoord:10.0 yCoord:14.0];
	STAssertFalse([node isEqual:unequalNode], nil);
	[unequalNode release];
}

- (void) testIsEqual {
	Node *equalNode = [[Node alloc] initWithXCoord:10.0 yCoord:15.0];	
	STAssertTrue([node isEqual:equalNode], nil);
	[equalNode release];
}

- (void) testIsNorthOf {
	Node *southNode = [[Node alloc] initWithXCoord:10.0 yCoord:20.0];
	STAssertTrue([node isNorthOf:southNode], nil);
	
	[southNode release];
}

- (void) testIsNotNorthOf {
	Node *northNode = [[Node alloc] initWithXCoord:10.0 yCoord:10.0];
	STAssertFalse([node isNorthOf:northNode], nil);
	
	[northNode release];

}

- (void) tearDown {
	
	[node release];
	
}


@end
