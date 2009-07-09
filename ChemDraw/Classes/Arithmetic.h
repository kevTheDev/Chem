//
//  Arithmetic.h
//  ChemDraw
//
//  Created by Kevin Edwards on 01/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PointObject;

@interface Arithmetic : NSObject {

}

+ (int)roundFloatDownToInteger:(float)numberToRound;

+ (NSArray *)straightLineCoordsBetweenPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo;


+ (float) yInterceptForPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo;
+ (float) gradientBetweenPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo;
+ (int) sampleRateForPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo;

+ (CGPoint) onePointCloserFromPointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo;

@end
