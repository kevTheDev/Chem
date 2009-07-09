//
//  Arithmetic.m
//  ChemDraw
//
//  Created by Kevin Edwards on 01/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Arithmetic.h"

#import "PointObject.h"

@implementation Arithmetic

+ (int)roundFloatDownToInteger:(float)numberToRound {
	
	float roundedValue = round(2.0f * numberToRound) / 2.0f;
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setMaximumFractionDigits:0];
	[formatter setRoundingMode: NSNumberFormatterRoundDown];
	
	NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
	
	[formatter release];
	return [numberString floatValue];;
	
}

+ (float) yInterceptForPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo {
	float gradient = [Arithmetic gradientBetweenPointOne:pointOne pointTwo:pointTwo];
	
	float c1 = pointTwo.y - (gradient * pointTwo.x);
	float c2 = pointOne.y - (gradient * pointOne.x);
	
	if(c1 != c2) {
		return -50; //should raise an exception here as something has gone horribly wrong
	}
	
	return c1;
	
	

}

// y = mx + c
+ (NSArray *)straightLineCoordsBetweenPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo {
	
	NSMutableArray *lineCoords = [[NSMutableArray alloc] init];
	
	//float gradient = [Arithmetic gradientBetweenPointOne:pointOne pointTwo:pointTwo];
	//float c = [Arithmetic yInterceptForPointOne:pointOne pointTwo:pointTwo];
	
	//int numberOfSamples = [Arithmetic sampleRateForPointOne:pointOne pointTwo:pointTwo];
	
	CGPoint movingPoint = pointOne;
	
	
	float xDistance = abs(movingPoint.x - pointTwo.x);
	float yDistance = abs(movingPoint.y - pointTwo.y);
	
	float distance = xDistance + yDistance;
	
	PointObject *firstPointObject = [[PointObject alloc] initWithPoint:movingPoint];
	[lineCoords addObject:firstPointObject];
	
	while(distance > 1.0) {
		movingPoint = [Arithmetic onePointCloserFromPointOne:movingPoint pointTwo:pointTwo];
		
		PointObject *pointObject = [[PointObject alloc] initWithPoint:movingPoint];
		[lineCoords addObject:pointObject];
		
		xDistance = abs(movingPoint.x - pointTwo.x);
		yDistance = abs(movingPoint.y - pointTwo.y);
	
		distance = xDistance + yDistance;		
	}
	
	PointObject *lastPointObject = [[PointObject alloc] initWithPoint:pointTwo];
	[lineCoords addObject:lastPointObject];
	
	return lineCoords;
}

+ (int) sampleRateForPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo {
	int xDistance = (int) abs(pointOne.x - pointTwo.x);
	int yDistance = (int) abs(pointOne.y - pointTwo.y);
	
	if(xDistance > yDistance)
		return xDistance;
	else if(yDistance > xDistance)
		return yDistance;
	else
		return xDistance;
	

}

+ (float) gradientBetweenPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo {

	float changeInY = abs(pointOne.y - pointTwo.y);
	float changeInX = abs(pointOne.x - pointTwo.x);
	
	float gradient = changeInY / changeInX;
	
	return gradient;

}

// moves one point closer to point two from point one
+ (CGPoint) onePointCloserFromPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo {

	float pointOneX = pointOne.x;
	float pointTwoX = pointTwo.x;
	
	float newPointX = pointOneX;
	
	if(pointOneX != pointTwoX) {
		if(pointOneX < pointTwoX) {
			newPointX = pointOneX + 1.0; 
		}
		else {
			newPointX = pointTwoX + 1.0;
		}	
	}
	
	float pointOneY = pointOne.y;
	float pointTwoY = pointTwo.y;
	
	float newPointY = pointOneY;
	
	if(pointOneY != pointTwoY) {
		if(pointOneY < pointTwoY) {
			newPointY = pointOneY + 1.0; 
		}
		else {
			newPointY = pointTwoY + 1.0;
		}	
	}

	return CGPointMake(newPointX, newPointY);
}

@end
