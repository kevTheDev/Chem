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
		//[completePointSet addObject:leftPoint2];
		//[completePointSet addObject:rightPoint2];
//		[completePointSet addObject:leftPoint3];
//		[completePointSet addObject:rightPoint3];
		
		[completePointSet addObject:northPoint];
		[completePointSet addObject:southPoint];
		//[completePointSet addObject:northPoint2];
		//[completePointSet addObject:southPoint2];
//		[completePointSet addObject:northPoint3];
//		[completePointSet addObject:southPoint3];
		
		
		
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

	
	
	
	int aCount = 0;
	int oCount = 0;
	int aPixelCheck;
	int oPixelCheck;
	
	
	int a[256] = {
	
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


};

	
	int *aPtr;
	int *oPtr;
	
	float aLineCount = 0;
	float aLinePercentage = 0;
	
	float oLineCount = 0;
	float oLinePercentage = 0;

	float totalAPercentage = 0;
	float totalOPercentage = 0;
	
	NSMutableString *debugString = [[NSMutableString alloc] init];
	NSString *ON = @"1 ";
	NSString *OFF = @"0 ";
	NSString *newLine = @"\n";
							
	[debugString appendString:newLine];												
																									
	for(int y=0; y<RESOLUTION; y++) {
		for(int x=0; x<RESOLUTION; x++) { //within this loop we are checking on horizontal line at a time
					
			int letterArrayIndex = (y*RESOLUTION) + x;
		
			aPtr = &a[letterArrayIndex];
			oPtr = &o[letterArrayIndex];
		
			aPixelCheck = a[letterArrayIndex];
			oPixelCheck = o[letterArrayIndex];
					
			CGPoint point = CGPointMake(x, y);
			PointObject *pointObject = [[PointObject alloc] initWithPoint:point];
					
					
					
			if( [completePointSet containsObject:pointObject] == YES ) {
			
				[debugString appendString:ON];
			
				NSLog(@"POINT SET CONTAINS POINT (%d, %d)", x, y);
				//NSLog(@"LETTER ARRAY INDEX: %d", letterArrayIndex);
			
				// the compressed point image has an ON PIXEL HERE
				if(aPixelCheck == 1) { // the a character has an ON pixel at this point
					aLineCount++;
				}
				
				if(oPixelCheck == 1) {
					oLineCount++;
				}
			}
			else { // the compressed point image has an OFF PIXEL HERE
				
				[debugString appendString:OFF];
				
				//NSLog(@"POINT SET DOES NOT CONTAIN POINT (%d, %d)", x, y);
				
				if(aPixelCheck == 0) { // the a character has an OFF pixel at this point
					aLineCount++;
				}
				
				if(oPixelCheck == 0) {
					oLineCount++;
				}
			}
			
			[pointObject release];
					
			
	
		} // end of row loop
		
		[debugString appendString:newLine];
				
		aLinePercentage = (aLineCount / RESOLUTION) * 100;
		totalAPercentage += aLinePercentage;

		NSLog(@"A LINE PERCENTAGE FOR LINE %d: %f", y, aLinePercentage);
		
		oLinePercentage = (oLineCount / RESOLUTION) * 100;
		totalOPercentage += oLinePercentage;

		NSLog(@"O LINE PERCENTAGE: %f", oLinePercentage);
		
		aLinePercentage = 0;
		aLineCount = 0;
		
		oLinePercentage = 0;
		oLineCount = 0;
		
	} // end of column loop
		
	
	NSLog(@"Final A COUNT: %d", aCount);
	NSLog(@"Final O COUNT: %d", oCount);

	totalAPercentage = totalAPercentage / RESOLUTION;	
	totalOPercentage = totalOPercentage / RESOLUTION;



	NSLog(@"Final A: %f%", totalAPercentage);
	NSLog(@"Final O: %f%", totalOPercentage);
	
	NSLog(@"%@", debugString);
}



- (void) dealloc {
	[compressedPointObjects release];
	[completePointSet release];
	[pointObjects release];
	
	[super dealloc];

}


@end
