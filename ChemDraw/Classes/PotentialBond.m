//
//  PotentialBond.m
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PotentialBond.h"


@implementation PotentialBond

- (PotentialBond *)initWithStartPoint:(CGPoint)pointOne endPoint:(CGPoint)pointTwo {
	self = [super init];
	
	if(self) {
		startPoint = pointOne;
		endPoint = pointTwo;
	}
	
	return self;
	
}

- (void) renderWithContext:(CGContextRef)ctx {
	CGMutablePathRef path = CGPathCreateMutable();
	

	
	//NSLog(@"DO REGULAR LINE");
	CGPathMoveToPoint(path, NULL, startPoint.x + 5.0, startPoint.y + 5.0);
	CGPathAddLineToPoint(path, NULL, endPoint.x + 5.0, endPoint.y + 5.0);
	
	
	CGPathCloseSubpath(path);
	CGContextAddPath(ctx, path);
	
	
	CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);

	
	CGContextSetLineWidth(ctx, 1.0);
	CGContextStrokePath(ctx);
	
	return;
	
}

@end

