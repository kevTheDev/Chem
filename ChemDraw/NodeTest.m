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
#import <ApplicationServices/ApplicationServices.h>

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

	Node *northNode = [[Node alloc] initWithXCoord:10.0 yCoord:10.0];
	Node *southNode = [[Node alloc] initWithXCoord:10.0 yCoord:20.0];
	STAssertTrue([northNode isNorthOf:southNode], nil);
}

- (void) testIsNotNorthOf {
	Node *northNode = [[Node alloc] initWithXCoord:10.0 yCoord:10.0];
	Node *southNode = [[Node alloc] initWithXCoord:10.0 yCoord:20.0];
	STAssertFalse([southNode isNorthOf:northNode], nil);
}

- (void) testIsSouthOf {
	Node *northNode = [[Node alloc] initWithXCoord:10.0 yCoord:10.0];
	Node *southNode = [[Node alloc] initWithXCoord:10.0 yCoord:20.0];
	STAssertTrue([southNode isSouthOf:northNode], nil);
}

- (void) testIsNotSouthOf {
	Node *northNode = [[Node alloc] initWithXCoord:10.0 yCoord:10.0];
	Node *southNode = [[Node alloc] initWithXCoord:10.0 yCoord:20.0];
	STAssertFalse([northNode isSouthOf:southNode], nil);
}

- (void) testIsEastOf {
	Node *eastNode = [[Node alloc] initWithXCoord:20.0 yCoord:10.0];
	Node *westNode = [[Node alloc] initWithXCoord:10.0 yCoord:20.0];
	
	STAssertTrue([eastNode isEastOf:westNode], nil);
}

- (void) testIsNotEastOf {
	Node *eastNode = [[Node alloc] initWithXCoord:20.0 yCoord:10.0];
	Node *westNode = [[Node alloc] initWithXCoord:10.0 yCoord:20.0];
	
	STAssertFalse([westNode isEastOf:eastNode], nil);
}

- (void) testIsWestOf {
	Node *eastNode = [[Node alloc] initWithXCoord:20.0 yCoord:10.0];
	Node *westNode = [[Node alloc] initWithXCoord:10.0 yCoord:20.0];
	
	STAssertTrue([westNode isWestOf:eastNode], nil);
}

- (void) testIsNotWestOf {
	Node *eastNode = [[Node alloc] initWithXCoord:20.0 yCoord:10.0];
	Node *westNode = [[Node alloc] initWithXCoord:10.0 yCoord:20.0];
	
	STAssertFalse([eastNode isWestOf:westNode], nil);
}

- (void) tearDown {
	
	[node release];
	
}


@end
