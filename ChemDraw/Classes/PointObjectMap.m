//
//  PointObjectMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 07/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PointObjectMap.h"
#import "PointObject.h"

#import <UIKit/UIKit.h>

#import "Arithmetic.h"
#import "Alphabet.h"

@implementation PointObjectMap




- (PointObjectMap *) init {
	
	self = [super init];
	
    if ( self ) {
        pointObjects = [[NSMutableArray alloc] initWithCapacity:5];
		completePointSet = [[NSMutableArray alloc] initWithCapacity:5];
		compressedPointObjects = [[NSMutableArray alloc] initWithCapacity:5];
    }
	
    return self;
	
}

- (void) addPoint:(PointObject *)pointObject {
	[pointObjects addObject:pointObject];

}

- (CGPoint) northPoint {

	CGPoint tempPoint;
	
	PointObject *tempPointObject = [pointObjects objectAtIndex:0];
	CGPoint currentTopPoint = [tempPointObject originalPoint];
	
	for(PointObject *pointObject in pointObjects) {
		tempPoint = [pointObject originalPoint];
		
		if(tempPoint.y < currentTopPoint.y) {
			currentTopPoint = tempPoint;
		}
	}
	
	return currentTopPoint;
}

- (CGPoint)southPoint {
	CGPoint tempPoint;
	
	PointObject *tempPointObject = [pointObjects objectAtIndex:0];
	CGPoint currentBottomPoint = [tempPointObject originalPoint];
	
	for(PointObject *pointObject in pointObjects) {
		tempPoint = [pointObject originalPoint];
		
		if(tempPoint.y > currentBottomPoint.y) {
			currentBottomPoint = tempPoint;
		}
	}
	
	return currentBottomPoint;

}

- (CGPoint) westPoint {
	CGPoint tempPoint;
	
	PointObject *tempPointObject = [pointObjects objectAtIndex:0];
	CGPoint currentWestPoint = [tempPointObject originalPoint];
	
	for(PointObject *pointObject in pointObjects) {
		tempPoint = [pointObject originalPoint];
		
		if(tempPoint.x < currentWestPoint.x) {
			currentWestPoint = tempPoint;
		}
	}
	
	return currentWestPoint;
}

- (CGPoint) eastPoint {
	CGPoint tempPoint;
	
	PointObject *tempPointObject = [pointObjects objectAtIndex:0];
	CGPoint currentEastPoint = [tempPointObject originalPoint];
	
	for(PointObject *pointObject in pointObjects) {
		tempPoint = [pointObject originalPoint];
		
		if(tempPoint.x > currentEastPoint.x) {
			currentEastPoint = tempPoint;
		}
	}
	
	return currentEastPoint;
}

- (CGFloat) yDistance {
	
	CGPoint northPoint = [self northPoint];
	CGPoint southPoint = [self southPoint];

	float yDistance = southPoint.y - northPoint.y;
	return yDistance;
}

- (CGFloat) xDistance {
	CGPoint westPoint = [self westPoint];
	CGPoint eastPoint = [self eastPoint];

	//NSLog(@"WEST POINT: %f", westPoint);
	//NSLog(@"EAST POINT: %f", eastPoint.);

	float xDistance = eastPoint.x - westPoint.x;
	return xDistance;
}

// takes original points and adds in missing points by calculating points on straight lines
// then compresses those points
// removes any points that are identical
// then we are ready for the symbolic binary field comparison
- (void) compressPoints {

	
	
	CGPoint point;

	NSLog(@"X DISTANCE: %f", [self xDistance]);
	NSLog(@"Y DISTANCE: %f", [self yDistance]);


	float pointX16 = [self xDistance] / 16;
	float pointY16 = [self yDistance] / 16;

	NSLog(@"X16: %f", pointX16);
	NSLog(@"Y16: %f", pointY16);

	float compressedX;
	float compressedY;
	
	int compressedXInt;
	int compressedYInt;

	for(PointObject *pointObject in pointObjects) {
		point = [pointObject originalPoint];
		
		//NSLog(@"ORIGINAL X: %f", point.x);
		//NSLog(@"ORIGINAL Y: %f", point.y);
		
		//if(pointX16 < 1) {
//			compressedX = point.x * pointX16;
//		}
//		else {
			compressedX = point.x / pointX16;
//		}
//		
//		if(pointY16 < 1) {
//			compressedY = point.y * pointY16;
//		}
//		else {
			compressedY = point.y / pointY16;
//		}

		//compressedX = point.x / 20;
		//compressedY = point.y / 30;
		
		compressedXInt =  [Arithmetic roundFloatDownToInteger:compressedX];
		compressedYInt =  [Arithmetic roundFloatDownToInteger:compressedY];
		
		//NSLog(@"COMPRESSED X: %d", compressedXInt);
		//NSLog(@"COMPRESSED Y: %d", compressedYInt);
		
		PointObject *newPointObject = [[PointObject alloc] initWithPoint:CGPointMake(compressedXInt, compressedYInt)];
		[compressedPointObjects addObject:newPointObject];
		
	}
	
	//NSLog(@"Original compressed count: %d", [compressedPointObjects count]);
	
	// fill in the missing points
	[self fillInMissingPoints];

	// add some extra points (one either side) to simulate a thicker line
	[self thickenLine];
	//NSLog(@"New compressed count: %d", [compressedPointObjects count]);
	
	[self buildComparisonArray];

	//for(PointObject *pointObject in compressedPointObjects) {
//		NSLog(@"COMPRESSED X: %f", [pointObject x]);
//		NSLog(@"COMPRESSED Y: %f", [pointObject y]);
//	}

	return;
}

- (void) thickenLine {
	
	int compressedPointObjectsCount = [completePointSet count];
	
	for(int i=0; i<compressedPointObjectsCount; i++) {
		
		
		PointObject *currentPointObject = [completePointSet objectAtIndex:i];
		CGPoint currentPoint = [currentPointObject originalPoint];

		CGPoint pointToLeft = CGPointMake(currentPoint.x - 1, currentPoint.y);
		CGPoint pointToRight = CGPointMake(currentPoint.x + 1, currentPoint.y);
			
		PointObject *leftPoint = [[PointObject alloc] initWithPoint:pointToLeft];
		PointObject *rightPoint = [[PointObject alloc] initWithPoint:pointToRight];
		
		CGPoint pointToLeft2 = CGPointMake(currentPoint.x - 2, currentPoint.y);
		CGPoint pointToRight2 = CGPointMake(currentPoint.x + 2, currentPoint.y);
			
		PointObject *leftPoint2 = [[PointObject alloc] initWithPoint:pointToLeft2];
		PointObject *rightPoint2 = [[PointObject alloc] initWithPoint:pointToRight2];
		
		CGPoint pointToLeft3 = CGPointMake(currentPoint.x - 3, currentPoint.y);
		CGPoint pointToRight3 = CGPointMake(currentPoint.x + 3, currentPoint.y);
			
		PointObject *leftPoint3 = [[PointObject alloc] initWithPoint:pointToLeft3];
		PointObject *rightPoint3 = [[PointObject alloc] initWithPoint:pointToRight3];
		
		CGPoint pointToNorth = CGPointMake(currentPoint.x, currentPoint.y - 1);
		CGPoint pointToSouth = CGPointMake(currentPoint.x, currentPoint.y + 1);
			
		PointObject *northPoint = [[PointObject alloc] initWithPoint:pointToNorth];
		PointObject *southPoint = [[PointObject alloc] initWithPoint:pointToSouth];
		
		CGPoint pointToNorth2 = CGPointMake(currentPoint.x, currentPoint.y - 3);
		CGPoint pointToSouth2 = CGPointMake(currentPoint.x, currentPoint.y + 3);
			
		PointObject *northPoint2 = [[PointObject alloc] initWithPoint:pointToNorth2];
		PointObject *southPoint2 = [[PointObject alloc] initWithPoint:pointToSouth2];
		
		CGPoint pointToNorth3 = CGPointMake(currentPoint.x, currentPoint.y - 3);
		CGPoint pointToSouth3 = CGPointMake(currentPoint.x, currentPoint.y + 3);
			
		PointObject *northPoint3 = [[PointObject alloc] initWithPoint:pointToNorth3];
		PointObject *southPoint3 = [[PointObject alloc] initWithPoint:pointToSouth3];


		
		[completePointSet addObject:leftPoint];
		[completePointSet addObject:rightPoint];
		[completePointSet addObject:leftPoint2];
		[completePointSet addObject:rightPoint2];
		[completePointSet addObject:leftPoint3];
		[completePointSet addObject:rightPoint3];
		
		[completePointSet addObject:northPoint];
		[completePointSet addObject:southPoint];
		[completePointSet addObject:northPoint2];
		[completePointSet addObject:southPoint2];
		[completePointSet addObject:northPoint3];
		[completePointSet addObject:southPoint3];
		
		
		
	}

	return;
}

- (void) fillInMissingPoints {
	
	CGPoint currentPoint;
	CGPoint previousPoint;
		
	PointObject *currentPointObject;
	PointObject *previousPointObject;

	NSArray *linePoints;
		
	int compressedPointObjectsCount = [compressedPointObjects count];	
		
	for(int i=1; i<compressedPointObjectsCount; i++) {
				
		previousPointObject = [compressedPointObjects objectAtIndex:i - 1];
		previousPoint = [previousPointObject originalPoint];
				
		currentPointObject = [compressedPointObjects objectAtIndex:i];
		currentPoint = [currentPointObject originalPoint];

		linePoints = [Arithmetic straightLineCoordsBetweenPointOne:previousPoint pointTwo:currentPoint];
			
		[completePointSet addObjectsFromArray:linePoints];
			
	}
	
	// now we should have a complete point set tracing the movement of the user's finger	
	return;
	
	
}


- (void) renderCompressedPointsWithContext:(CGContextRef)ctx {
	CGPoint currentPoint;
		
	PointObject *currentPointObject;

	for(int i=0; i<[completePointSet count]; i++) {
		
			
		currentPointObject = [completePointSet objectAtIndex:i];
		currentPoint = [currentPointObject originalPoint];
			
		[self renderPoint:currentPoint withContext:ctx];
	}
}




- (void) renderWithContext:(CGContextRef)ctx {
	CGPoint currentPoint;
	CGPoint previousPoint;
		
	PointObject *currentPointObject;
	PointObject *previousPointObject;
		
	float lineWidth = 5.0;	
	
	for(int i=1; i<[pointObjects count]; i++) {
		
			previousPointObject = [pointObjects objectAtIndex:i - 1];
			previousPoint = [previousPointObject originalPoint];
				
			currentPointObject = [pointObjects objectAtIndex:i];
			currentPoint = [currentPointObject originalPoint];
			
			float distanceBetweenPoints = [Arithmetic distanceBetweenPointOne:previousPoint pointTwo:currentPoint];
			if(distanceBetweenPoints < 100.0) {
				[self renderLineFromPoint:previousPoint toPoint:currentPoint withContext:ctx lineWidth:lineWidth];
			}
		}
}

- (void) renderPoint:(CGPoint)point withContext:(CGContextRef)ctx {	
	
	CGContextSetRGBFillColor(ctx, 0, 255, 0, 1.0);
    CGContextFillEllipseInRect(ctx, CGRectMake(point.x, point.y, 1.0, 1.0));
	
}

- (void) renderLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint withContext:(CGContextRef)ctx lineWidth:(float)lineWidth {
	
	CGMutablePathRef path = CGPathCreateMutable();
	
	CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
	CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
	
	CGPathCloseSubpath(path);
	CGContextAddPath(ctx, path);
	
	CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
	
	CGContextSetLineWidth(ctx, lineWidth);
	CGContextStrokePath(ctx);
	
	return;
}

- (void) buildComparisonArray {

	
	Alphabet *alphabet = [[Alphabet alloc] init];
	
	
	int aCount = 0;
	int bCount = 0;
	int cCount = 0;
	int dCount = 0;
	int eCount = 0;
	int fCount = 0;
	int gCount = 0;
	int hCount = 0;
	int iCount = 0;
	int jCount = 0;
	int kCount = 0;
	int lCount = 0;
	int mCount = 0;
	int nCount = 0;
	int oCount = 0;
	int pCount = 0;
	int qCount = 0;
	int rCount = 0;
	int sCount = 0;
	int tCount = 0;
	int uCount = 0;
	int vCount = 0;
	int wCount = 0;
	int xCount = 0;
	int yCount = 0;
	int zCount = 0;
	int aPixelCheck;
	int oPixelCheck;
	
	
	int a[256] = {

		//0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,
//		0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
//		0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,
//		0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,
//		0,0,0,1,1,1,1,0,0,1,1,1,1,0,0,0,
//		0,0,0,1,1,1,1,0,0,1,1,1,1,0,0,0,
//		0,0,0,1,1,1,1,0,0,1,1,1,1,0,0,0,
//		0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,
//		0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,
//		0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
//		0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
//		0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
//		0,1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,
//		0,1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,
//		0,1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,
//		1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1
		
		
		0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,
		0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,
		0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
		0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,
		0,0,0,0,1,1,1,0,0,1,1,1,0,0,0,0,
		0,0,0,0,1,1,1,0,0,1,1,1,0,0,0,0,
		0,0,0,1,1,1,0,0,0,0,1,1,1,0,0,0,
		0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,
		0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
		0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
		0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,
		0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,
		1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
		1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1		
		
		
		
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,
		0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,
		0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,
		0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,
		0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,
		0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,
		0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,
		0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,
		0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,
		0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,
		0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,
		0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,
		1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
		1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
				
	};
	
	int o[256] =

{
0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,
0,0,1,1,0,0,0,0,0,0,0,0,1,1,0,0,
0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,
0,0,1,1,0,0,0,0,0,0,0,0,1,1,0,0,
0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0


0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,
0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,
0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,
0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,
0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,
0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,
0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,
0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,
0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,
1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,
0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,
0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,
0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,
0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,
0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,
0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,
0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,
0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

};

	
	int *aPtr;
	int *oPtr;
	
	
	for(int x=0; x<16; x++) {
		for(int y=0; y<16; y++) {
		
		int letterArrayIndex = (x*16) + y;
		
		aPtr = &a[letterArrayIndex];
		oPtr = &o[letterArrayIndex];
		
		aPixelCheck = a[letterArrayIndex];
		oPixelCheck = o[letterArrayIndex];
		//NSLog(@"oPixelCheck %d", oPixelCheck);
		
		for(PointObject *pointObject in completePointSet) {
			CGPoint point = [pointObject originalPoint];
			int pointX = point.x;
			int pointY = point.y;
			
			//NSLog(@"%d, %d, %d %d", pointX, pointY, x, y);
			
			if( (pointX == x) && (pointY == y) ) { //we have an on pixel at this coord
	
				if(aPixelCheck == 1)
					aCount += 1;

				if(oPixelCheck == 1)
					oCount += 1;
				
			
				
			}
			else { // we have an off pixel at this coord
				if(aPixelCheck == 0)
					aCount += 2;

				if(oPixelCheck == 0)
					oCount += 2;
			}
			
			}
		}
		
		
	}
	
	NSLog(@"Final A COUNT: %d", aCount);
	NSLog(@"Final O COUNT: %d", oCount);




}



- (void) dealloc {
	[compressedPointObjects release];
	[completePointSet release];
	[pointObjects release];
	
	[super dealloc];

}


@end
