//
//  PointObjectMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 07/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

# define RESOLUTION 16

@class PointObject;
@class CharacterMatch;

@interface PointObjectMap : NSObject {
	NSMutableArray *pointObjects;
	NSMutableArray *completePointSet;
	NSMutableArray *compressedPointObjects;
}

- (void) clearPoints;
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

- (CharacterMatch *) compressPoints;
- (void) fillInMissingPoints;
- (void) thickenLine;
- (CharacterMatch *) buildComparisonArray;

- (void) renderPoint:(CGPoint)point withContext:(CGContextRef)ctx;

@end
