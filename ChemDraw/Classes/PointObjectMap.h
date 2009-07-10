//
//  PointObjectMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 07/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PointObject;

@interface PointObjectMap : NSObject {
	NSMutableArray *pointObjects;
	NSMutableArray *completePointSet;
	NSMutableArray *compressedPointObjects;
}

- (void) addPoint:(PointObject *)pointObject;

- (void) renderWithContext:(CGContextRef)ctx;
- (void) renderCompressedPointsWithContext:(CGContextRef)ctx;

- (void) renderLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint withContext:(CGContextRef)ctx  lineWidth:(float)lineWidth;

- (CGPoint) northPoint;
- (CGPoint) southPoint;

- (CGPoint) westPoint;
- (CGPoint) eastPoint;

- (CGFloat) xDistance;
- (CGFloat) yDistance;

- (void) compressPoints;
- (void) fillInMissingPoints;
- (void) thickenLine;

- (void) renderPoint:(CGPoint)point withContext:(CGContextRef)ctx;

@end
