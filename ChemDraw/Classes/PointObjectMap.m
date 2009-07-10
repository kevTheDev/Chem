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

	float compressedX;
	float compressedY;

	for(PointObject *pointObject in pointObjects) {
		point = [pointObject originalPoint];
		
		compressedX = point.x / pointX16;
		compressedY = point.y / pointY16;
		
		//NSLog(@"COMPRESSED X: %f", compressedX);
		//NSLog(@"COMPRESSED Y: %f", compressedY);
		
		PointObject *newPointObject = [[PointObject alloc] initWithPoint:CGPointMake(compressedX, compressedY)];
		[compressedPointObjects addObject:newPointObject];
		
	}
	
	NSLog(@"Original compressed count: %d", [compressedPointObjects count]);
	
	// fill in the missing points
	//[self fillInMissingPoints];

	// add some extra points (one either side) to simulate a thicker line
	[self thickenLine];
	NSLog(@"New compressed count: %d", [compressedPointObjects count]);

	return;
}

- (void) thickenLine {
	
	int compressedPointObjectsCount = [compressedPointObjects count];
	
	for(int i=0; i<compressedPointObjectsCount; i++) {
		
		NSLog(@"Thicken line loop: %d", i);
		
		PointObject *currentPointObject = [compressedPointObjects objectAtIndex:i];
		CGPoint currentPoint = [currentPointObject originalPoint];

		CGPoint pointToLeft = CGPointMake(currentPoint.x - 1, currentPoint.y);
		CGPoint pointToRight = CGPointMake(currentPoint.x + 1, currentPoint.y);
			
		PointObject *leftPoint = [[PointObject alloc] initWithPoint:pointToLeft];
		PointObject *rightPoint = [[PointObject alloc] initWithPoint:pointToRight];
		
		CGPoint pointToLeft2 = CGPointMake(currentPoint.x - 2, currentPoint.y);
		CGPoint pointToRight2 = CGPointMake(currentPoint.x + 2, currentPoint.y);
			
		PointObject *leftPoint2 = [[PointObject alloc] initWithPoint:pointToLeft2];
		PointObject *rightPoint2 = [[PointObject alloc] initWithPoint:pointToRight2];
		
		[compressedPointObjects addObject:leftPoint];
		[compressedPointObjects addObject:rightPoint];
		[compressedPointObjects addObject:leftPoint2];
		[compressedPointObjects addObject:rightPoint2];
		
		
		
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
		
		NSLog(@"Fill missing points loop: %d", i);
		
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
		

	//
//	for(int i=0; i<[compressedPointObjects count]; i++) {
//		
//		if(i > 0) {
//			previousPointObject = [compressedPointObjects objectAtIndex:i - 1];
//			previousPoint = [previousPointObject originalPoint];
//				
//			currentPointObject = [compressedPointObjects objectAtIndex:i];
//			currentPoint = [currentPointObject originalPoint];
//			
//			[self renderLineFromPoint:previousPoint toPoint:currentPoint withContext:ctx lineWidth:lineWidth];
//		}
//	}


	for(int i=0; i<[compressedPointObjects count]; i++) {
		
			
		currentPointObject = [compressedPointObjects objectAtIndex:i];
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
	
	for(int i=0; i<[pointObjects count]; i++) {
		
		if(i > 0) {
			previousPointObject = [pointObjects objectAtIndex:i - 1];
			previousPoint = [previousPointObject originalPoint];
				
			currentPointObject = [pointObjects objectAtIndex:i];
			currentPoint = [currentPointObject originalPoint];
			
			
			
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

- (void) dealloc {
	[compressedPointObjects release];
	[completePointSet release];
	[pointObjects release];
	
	[super dealloc];

}


@end
