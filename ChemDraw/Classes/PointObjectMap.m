//
//  PointObjectMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 07/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PointObjectMap.h"
#import "PointObject.h"

@implementation PointObjectMap

- (PointObjectMap *) init {
	
	self = [super init];
	
    if ( self ) {
        pointObjects = [[NSMutableArray alloc] initWithCapacity:5];
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

- (void) compressPoints {

	CGPoint point;

	NSLog(@"X DISTANCE: %f", [self xDistance]);
	NSLog(@"Y DISTANCE: %f", [self yDistance]);


	float pointX16 = [self xDistance] / 16;
	float pointY16 = [self yDistance] / 16;

	float compressedX;
	float compressedY;

	for(PointObject *pointObject in pointObjects) {
		point = [pointObject originalPoint];
		
		compressedX = point.x / pointX16;
		compressedY = point.y / pointY16;
		
		NSLog(@"COMPRESSED X: %f", compressedX);
		NSLog(@"COMPRESSED Y: %f", compressedY);
		
		PointObject *newPointObject = [[PointObject alloc] initWithPoint:CGPointMake(compressedX, compressedY)];
		[compressedPointObjects addObject:newPointObject];
		
	}

	return;
}

- (void) renderCompressedPointsWithContext:(CGContextRef)ctx {
	CGPoint currentPoint;
	CGPoint previousPoint;
		
	PointObject *currentPointObject;
	PointObject *previousPointObject;
		
		
	
	for(int i=0; i<[compressedPointObjects count]; i++) {
		
		if(i > 0) {
			previousPointObject = [compressedPointObjects objectAtIndex:i - 1];
			previousPoint = [previousPointObject originalPoint];
				
			currentPointObject = [compressedPointObjects objectAtIndex:i];
			currentPoint = [currentPointObject originalPoint];
			
			[self renderLineFromPoint:previousPoint toPoint:currentPoint withContext:ctx];
		}
	}}

- (void) renderWithContext:(CGContextRef)ctx {
	CGPoint currentPoint;
	CGPoint previousPoint;
		
	PointObject *currentPointObject;
	PointObject *previousPointObject;
		
		
	
	for(int i=0; i<[pointObjects count]; i++) {
		
		if(i > 0) {
			previousPointObject = [pointObjects objectAtIndex:i - 1];
			previousPoint = [previousPointObject originalPoint];
				
			currentPointObject = [pointObjects objectAtIndex:i];
			currentPoint = [currentPointObject originalPoint];
			
			[self renderLineFromPoint:previousPoint toPoint:currentPoint withContext:ctx];
		}
	}
}

- (void) renderLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint withContext:(CGContextRef)ctx {
	
	CGMutablePathRef path = CGPathCreateMutable();
	
	CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
	CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
	
	CGPathCloseSubpath(path);
	CGContextAddPath(ctx, path);
	
	CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
	
	CGContextSetLineWidth(ctx, 5.0);
	CGContextStrokePath(ctx);
	
	return;
}



@end
