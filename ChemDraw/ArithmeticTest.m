//
//  ArithmeticTest.m
//  ChemDraw
//
//  Created by Kevin Edwards on 01/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

#import "Arithmetic.h"

@interface ArithmeticTest : SenTestCase {
	
}

@end

@implementation ArithmeticTest

- (void) testFloatToInteger {
	
	float testFloat = 10.000;
	
	STAssertEquals([Arithmetic roundFloatDownToInteger:testFloat], 10, nil);
}

@end
