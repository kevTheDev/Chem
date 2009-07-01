//
//  NodeTest.m
//  ChemDraw
//
//  Created by Kevin Edwards on 30/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

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

- (void) testConfirmSelection {
	STAssertFalse([node confirmedHighlight], nil);	
	[node confirmSelection];	
	STAssertTrue([node confirmedHighlight], nil);
}

- (void) testConfirmSelectionResetsHighlight {
	[node highlight];
	[node confirmSelection];
	STAssertFalse([node isHighlighted], nil);
}

- (void) testIsSelected {
	STAssertFalse([node isSelected], nil);
	[node confirmSelection];
	STAssertTrue([node isSelected], nil);
}

- (void) testInitXCoord {
	STAssertEquals((float) [node xCoord], 10.0f, nil);
}


- (void) testInitYCoord {
	STAssertEquals((float) [node yCoord], 15.0f, nil);
}

- (void) testXCoordForHash {
	
	STAssertEquals([node xCoordForHash], 10, nil);
	
}

- (void) testYCoordForHash {
	
	STAssertEquals([node yCoordForHash], 15, nil);
	
}

- (void) testHashString {
	
	NSString *expectedHash = @"1015";
	
	STAssertEqualObjects([node hashString], expectedHash, nil);
	
}

- (void) testHash {
	NSString *expectedHash = @"1015";
	NSUInteger actualHash = [node hash];
	
	int expectedHashInt = [expectedHash intValue];
	int actualHashInt   = (int) actualHash;
	
	STAssertEquals(actualHashInt, expectedHashInt, nil);

}

- (void) testIsEqual {
	Node *equalNode = [[Node alloc] initWithXCoord:10.0 yCoord:15.0];	
	STAssertTrue([node isEqual:equalNode], nil);
	[equalNode release];
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

- (void) tearDown {
	
	[node release];
	
}


@end
