//
//  Node.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Node.h"



@implementation Node

@synthesize xCoord;
@synthesize yCoord;
@synthesize unconfirmedHighlight;
@synthesize confirmedHighlight;
@synthesize elementType;
@synthesize displayPotentialBondMap;

int DRAW_WIDTH = 10;
int DRAW_HEIGHT = 10;

- (Node *) initWithXCoord:(CGFloat)x yCoord:(CGFloat)y {
	
	self = [super init];
	
    if ( self ) {
		xCoord = x;
		yCoord = y;
		
		elementType = @"Carbon";
		
		displayPotentialBondMap = NO;
		
		// set up the potential bond map for when we do need to display it
		potentialBondMap = [[PotentialBondMap alloc] init];
		
		
		CGPoint startPoint = CGPointMake(xCoord, yCoord);
		CGPoint bondOnePoint = CGPointMake(xCoord, yCoord + 50);
		CGPoint bondTwoPoint = CGPointMake(xCoord + 50, yCoord);
		CGPoint bondThreePoint = CGPointMake(xCoord, yCoord - 50);
		
		PotentialBond *bondOne = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:bondOnePoint];
		PotentialBond *bondTwo = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:bondTwoPoint];
		PotentialBond *bondThree = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:bondThreePoint];
		
		[potentialBondMap addPotentialBond:bondOne];
		[potentialBondMap addPotentialBond:bondTwo];
		[potentialBondMap addPotentialBond:bondThree];
		
		
    }
	
    return self;
	
}

- (void) select {
	[self setUnconfirmedHighlight:NO];
	[self setConfirmedHighlight:YES];
}

- (BOOL) isSelected {
	return [self confirmedHighlight];
}

- (void) highlight {
	[self setUnconfirmedHighlight:YES];	
}

- (BOOL) isHighlighted {
	
	return ([self unconfirmedHighlight]);
}

- (int) xCoordForHash {
	
	return [Arithmetic roundFloatDownToInteger:[self xCoord]];
}

- (int) yCoordForHash {
	
	return [Arithmetic roundFloatDownToInteger:[self yCoord]];
}


- (NSUInteger)hash {
	
	NSString *hashString = [NSString stringWithFormat:@"%d%d", [self xCoordForHash], [self yCoordForHash]];	
	return [hashString intValue];
}

- (BOOL)isEqual:(id)anObject {
	
	if([anObject class] != [self class]) {
		return false;
	}
	
	if( [anObject xCoord] == [self xCoord] && [anObject yCoord] == [self yCoord] ) {
		return true;
	}

	return false;
}

- (void) highlightClosestPotentialBondToPoint:(CGPoint)point {
	[potentialBondMap highlightClosestPotentialBondToPoint:point];
}

- (void) renderWithContext:(CGContextRef)ctx {	
	if([self isSelected]) {
		CGContextSetRGBFillColor(ctx, 0, 255, 0, 1.0);
	}
	else if([self isHighlighted]) {
		CGContextSetRGBFillColor(ctx, 255, 255, 0, 1.0);
	}
	else{
		CGContextSetRGBFillColor(ctx, 255, 0, 0, 1.0);
	}
	
    CGContextFillEllipseInRect(ctx, CGRectMake(xCoord, yCoord, DRAW_WIDTH, DRAW_HEIGHT));
	
	
	if(elementType == @"Oxygen") {
		CGContextSetRGBStrokeColor(ctx, 0, 0, 255, 1);
		CGContextStrokeEllipseInRect(ctx, CGRectMake(xCoord + 6, yCoord - 6, 5, 5));
	}
	
	if(displayPotentialBondMap == YES) {
		[potentialBondMap renderWithContext:ctx];
	}
	
	return;
	
}

- (void) dealloc {
	
	[potentialBondMap release];
	[elementType release];
	[super dealloc];
	
}


@end
