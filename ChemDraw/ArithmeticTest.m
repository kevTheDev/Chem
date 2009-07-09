//
//  ArithmeticTest.m
//  ChemDraw
//
//  Created by Kevin Edwards on 01/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import <ApplicationServices/ApplicationServices.h>

#import "Arithmetic.h"
#import "PointObject.h"

@interface ArithmeticTest : SenTestCase {
	
}

@end

@implementation ArithmeticTest

- (void) testFloatToInteger {
	
	float testFloat = 10.000;
	
	STAssertEquals([Arithmetic roundFloatDownToInteger:testFloat], 10, nil);
}

- (void) testGradient {
	CGPoint origin = CGPointMake(0.0, 0.0);
	CGPoint pointTwo = CGPointMake(5.0, 3.0);
	
	float expectedGradient = 0.6;
	
	STAssertEquals([Arithmetic gradientBetweenPointOne:origin pointTwo:pointTwo], expectedGradient, nil);
}

- (void) testSampleRateForGreatestDistanceX {
	CGPoint origin = CGPointMake(0.0, 0.0);
	CGPoint pointTwo = CGPointMake(5.0, 3.0);
	
	int expectedSampleRate = 5;
	
	STAssertEquals([Arithmetic sampleRateForPointOne:(CGPoint)origin pointTwo:(CGPoint)pointTwo], expectedSampleRate, nil);
}

- (void) testSampleRateForGreatestDistanceY {
	CGPoint origin = CGPointMake(0.0, 0.0);
	CGPoint pointTwo = CGPointMake(3.0, 6.0);
	
	int expectedSampleRate = 6;
	
	STAssertEquals([Arithmetic sampleRateForPointOne:(CGPoint)origin pointTwo:(CGPoint)pointTwo], expectedSampleRate, nil);
}

- (void) testSampleRateForEqualXYDistance {
	CGPoint origin = CGPointMake(0.0, 0.0);
	CGPoint pointTwo = CGPointMake(3.0, 3.0);
	
	int expectedSampleRate = 3;
	
	STAssertEquals([Arithmetic sampleRateForPointOne:(CGPoint)origin pointTwo:(CGPoint)pointTwo], expectedSampleRate, nil);
}

- (void) testYIntercept {
	CGPoint pointOne = CGPointMake(2.0, 2.0);
	CGPoint pointTwo = CGPointMake(6.0, 14.0);
	
	float expectedYIntercept = -4.0;
	
	STAssertEquals([Arithmetic yInterceptForPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo], expectedYIntercept, nil);
}

- (void) testCoordsOfStraightLine {
	CGPoint origin = CGPointMake(0.0, 0.0);
	CGPoint pointTwo = CGPointMake(5.0, 3.0);
	
	NSArray *lineCoords = [Arithmetic straightLineCoordsBetweenPointOne:origin pointTwo:pointTwo];
	
	PointObject *firstPointObject = [lineCoords objectAtIndex:0];
	CGPoint firstPoint = [firstPointObject originalPoint];
	STAssertEquals(firstPoint.x, (CGFloat) 0.0, nil);
	STAssertEquals(firstPoint.y, (CGFloat) 0.0, nil);
	
	
	PointObject *secondPointObject = [lineCoords objectAtIndex:1];
	CGPoint secondPoint = [secondPointObject originalPoint];
	STAssertEquals(secondPoint.x, (CGFloat) 1.0, nil);
	STAssertEquals(secondPoint.y, (CGFloat) 1.0, nil);
	
	PointObject *thirdPointObject = [lineCoords objectAtIndex:2];
	CGPoint thirdPoint = [thirdPointObject originalPoint];
	STAssertEquals(thirdPoint.x, (CGFloat) 2.0, nil);
	STAssertEquals(thirdPoint.y, (CGFloat) 2.0, nil);
	
	PointObject *fourthPointObject = [lineCoords objectAtIndex:3];
	CGPoint fourthPoint = [fourthPointObject originalPoint];
	STAssertEquals(fourthPoint.x, (CGFloat) 3.0, nil);
	STAssertEquals(fourthPoint.y, (CGFloat) 3.0, nil);

	PointObject *fifthPointObject = [lineCoords objectAtIndex:4];
	CGPoint fifthPoint = [fifthPointObject originalPoint];
	STAssertEquals(fifthPoint.x, (CGFloat) 4.0, nil);
	STAssertEquals(fifthPoint.y, (CGFloat) 3.0, nil);
	
	PointObject *sixthPointObject = [lineCoords objectAtIndex:5];
	CGPoint sixthPoint = [sixthPointObject originalPoint];
	STAssertEquals(sixthPoint.x, (CGFloat) 5.0, nil);
	STAssertEquals(sixthPoint.y, (CGFloat) 3.0, nil);
	
	PointObject *lastPointObject = [lineCoords lastObject];
	CGPoint lastPoint = [lastPointObject originalPoint];
	STAssertEquals(lastPoint.x, (CGFloat) 5.0, nil);
	STAssertEquals(lastPoint.y, (CGFloat) 3.0, nil);

}

@end
