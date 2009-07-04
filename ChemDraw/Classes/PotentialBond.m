//
//  PotentialBond.m
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PotentialBond.h"


@implementation PotentialBond

@synthesize endPoint;
@synthesize centerPoint;

- (PotentialBond *)initWithStartPoint:(CGPoint)pointOne endPoint:(CGPoint)pointTwo {
	self = [super init];
	
	if(self) {
		startPoint = pointOne;
		endPoint = pointTwo;
		
		[self setupCenterPoint];
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

	
	if([self isHighlighted]) {
		CGContextSetStrokeColorWithColor(ctx, [UIColor purpleColor].CGColor);
	}
	else if([self isSelected]) {
		CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
	}
	else {
		CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
	}
	
	CGContextSetLineWidth(ctx, 1.0);
	CGContextStrokePath(ctx);
	
	return;
	
}

- (void) select {
	highlighted = NO;
	selected = YES;
}

- (BOOL) isSelected {
	return selected;
}

- (void) highlight {
	highlighted = YES;	
}

- (BOOL) isHighlighted {
	
	return highlighted;
}

// only called once in init
- (void) setupCenterPoint {
	
	float nodeAX = startPoint.x;
	float nodeBX = endPoint.x;
	
	float bigX;
	float littleX;
	
	if(nodeAX > nodeBX) {
		bigX = nodeAX;
		littleX = nodeBX;
	}
	else {
		bigX = nodeBX;
		littleX = nodeAX;
	}
	
	float distanceX = bigX - littleX;
	float halfDistanceX = distanceX / 2.0;
	
	float centerX = littleX + halfDistanceX;
	
	float nodeAY = startPoint.y;
	float nodeBY = endPoint.y;
	
	float bigY;
	float littleY;
	
	if(nodeAY > nodeBY) {
		bigY = nodeAY;
		littleY = nodeBY;
	}
	else {
		bigY = nodeAY;
		littleY = nodeBY;
	}
	
	float distanceY = bigY - littleY;
	float halfDistanceY = distanceY / 2.0;
	
	float centerY = littleY + halfDistanceY;
	
	
	
	[self setCenterPoint:CGPointMake(centerX, centerY)];
	
}


@end

