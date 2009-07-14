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


#import "Character.h"

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

	float xDistance = eastPoint.x - westPoint.x;
	return xDistance;
}

// takes original points and adds in missing points by calculating points on straight lines
// then compresses those points
// removes any points that are identical
// then we are ready for the symbolic binary field comparison
- (void) compressPoints {

	float shiftFromXOrigin = [self westPoint].x;
	float shiftFromYOrigin = [self northPoint].y;
	
	CGPoint point;

	NSLog(@"X DISTANCE: %f", [self xDistance]);
	NSLog(@"Y DISTANCE: %f", [self yDistance]);


	float pointX16 = [self xDistance] / RESOLUTION;
	float pointY16 = [self yDistance] / RESOLUTION;


	float compressedX;
	float compressedY;
	
	int compressedXInt;
	int compressedYInt;

	float shiftedPointX = 0;
	float shiftedPointY = 0;

	for(PointObject *pointObject in pointObjects) {
		point = [pointObject originalPoint];
		
		shiftedPointX = point.x - shiftFromXOrigin;
		shiftedPointY = point.y - shiftFromYOrigin;

		compressedX = shiftedPointX / pointX16;
		compressedY = shiftedPointY / pointY16;
		
		
		compressedXInt =  (int) [Arithmetic roundFloatDownToInteger:compressedX];
		compressedYInt =  (int) [Arithmetic roundFloatDownToInteger:compressedY];
		
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
	
	[self buildComparisonArray];


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
		



			

		
		CGPoint pointToNorth = CGPointMake(currentPoint.x, currentPoint.y - 1);
		CGPoint pointToSouth = CGPointMake(currentPoint.x, currentPoint.y + 1);
			
		PointObject *northPoint = [[PointObject alloc] initWithPoint:pointToNorth];
		PointObject *southPoint = [[PointObject alloc] initWithPoint:pointToSouth];
		




		
		[completePointSet addObject:leftPoint];
		[completePointSet addObject:rightPoint];

		
		[completePointSet addObject:northPoint];
		[completePointSet addObject:southPoint];

		
		
		
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
	
	CGFloat aMatch = [Character matchForA:completePointSet];
	CGFloat bMatch = [Character matchForB:completePointSet];
	CGFloat cMatch = [Character matchForC:completePointSet];
	CGFloat dMatch = [Character matchForD:completePointSet];
	CGFloat eMatch = [Character matchForE:completePointSet];
	CGFloat fMatch = [Character matchForF:completePointSet];
	CGFloat gMatch = [Character matchForG:completePointSet];
	CGFloat hMatch = [Character matchForH:completePointSet];
	CGFloat iMatch = [Character matchForI:completePointSet];
	CGFloat jMatch = [Character matchForJ:completePointSet];
	CGFloat kMatch = [Character matchForK:completePointSet];
	CGFloat lMatch = [Character matchForL:completePointSet];
	CGFloat mMatch = [Character matchForM:completePointSet];
	CGFloat nMatch = [Character matchForN:completePointSet];
	CGFloat oMatch = [Character matchForO:completePointSet];
	CGFloat pMatch = [Character matchForP:completePointSet];
	CGFloat qMatch = [Character matchForQ:completePointSet];
	CGFloat rMatch = [Character matchForR:completePointSet];
	CGFloat sMatch = [Character matchForS:completePointSet];
	CGFloat tMatch = [Character matchForT:completePointSet];
	CGFloat uMatch = [Character matchForU:completePointSet];
	CGFloat vMatch = [Character matchForV:completePointSet];
	CGFloat wMatch = [Character matchForW:completePointSet];
	CGFloat xMatch = [Character matchForX:completePointSet];
	CGFloat yMatch = [Character matchForY:completePointSet];
	CGFloat zMatch = [Character matchForZ:completePointSet];
	
	NSLog(@"Final A: %f%", aMatch);
	NSLog(@"Final B: %f%", bMatch);
	NSLog(@"Final C: %f%", cMatch);
	NSLog(@"Final D: %f%", dMatch);
	NSLog(@"Final E: %f%", eMatch);
	NSLog(@"Final F: %f%", fMatch);
	NSLog(@"Final G: %f%", gMatch);
	NSLog(@"Final H: %f%", hMatch);
	NSLog(@"Final I: %f%", iMatch);
	NSLog(@"Final J: %f%", jMatch);
	NSLog(@"Final K: %f%", kMatch);
	NSLog(@"Final L: %f%", lMatch);
	NSLog(@"Final M: %f%", mMatch);
	NSLog(@"Final N: %f%", nMatch);
	NSLog(@"Final O: %f%", oMatch);
	NSLog(@"Final P: %f%", pMatch);
	NSLog(@"Final Q: %f%", qMatch);
	NSLog(@"Final R: %f%", rMatch);
	NSLog(@"Final S: %f%", sMatch);
	NSLog(@"Final T: %f%", tMatch);
	NSLog(@"Final U: %f%", uMatch);
	NSLog(@"Final V: %f%", vMatch);
	NSLog(@"Final W: %f%", wMatch);
	NSLog(@"Final X: %f%", xMatch);
	NSLog(@"Final Y: %f%", yMatch);
	NSLog(@"Final Z: %f%", zMatch);

}



- (void) dealloc {
	[compressedPointObjects release];
	[completePointSet release];
	[pointObjects release];
	
	[super dealloc];

}


@end
