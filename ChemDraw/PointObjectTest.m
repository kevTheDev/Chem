//
//  PointObjectTest.m
//  ChemDraw
//
//  Created by Kevin Edwards on 10/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import <ApplicationServices/ApplicationServices.h>

#import "PointObject.h"

@interface PointObjectTest : SenTestCase {	
	PointObject *pointObject;
	
}

@end

@implementation PointObjectTest

- (void) setUp {
	CGPoint point = CGPointMake(4.3, 2.7);
	pointObject = [[PointObject alloc] initWithPoint:point];

}

- (void) testIsNotEqualIfNotPointObject {
	NSString *testString = @"";
	STAssertFalse([pointObject isEqualTo:testString], nil);
	
}

- (void) testIsNotEqualForDifferentX {
	CGPoint pointX = CGPointMake(5.0, 2.7);
	PointObject *pointObjectX = [[PointObject alloc] initWithPoint:pointX];
	
	STAssertFalse([pointObject isEqualTo:pointObjectX], nil);
}

- (void) testIsNotEqualForDifferentY {
	CGPoint pointY = CGPointMake(4.3, 2.9);
	PointObject *pointObjectY = [[PointObject alloc] initWithPoint:pointY];
	
	STAssertFalse([pointObject isEqualTo:pointObjectY], nil);

}


- (void) testIsEqual {
	CGPoint identicalPoint = CGPointMake(4.3, 2.7);
	PointObject *identicalPointObject = [[PointObject alloc] initWithPoint:identicalPoint];
	
	STAssertTrue([pointObject isEqualTo:identicalPointObject], nil);
}

- (void) testHash {
	NSString *expectedHash = @"42";
	NSUInteger actualHash = [pointObject hash];
	
	int expectedHashInt = [expectedHash intValue];
	int actualHashInt   = (int) actualHash;
	
	STAssertEquals(actualHashInt, expectedHashInt, nil);

}

- (void) tearDown {
	[pointObject release];	
}


@end
