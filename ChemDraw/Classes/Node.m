//
//  Node.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Node.h"
#import "Arithmetic.h"
#import "PotentialBond.h"
#import "PotentialBondMap.h"

#import "Bond.h"
#import "BondMap.h"

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

		
		connectingBonds = [[BondMap alloc] init];
		
				
		
    }
	
    return self;
	
}

- (void) select {
	[self setUnconfirmedHighlight:NO];
	[self setConfirmedHighlight:YES];
}

- (void) deSelect {
	displayPotentialBondMap	= NO;
	confirmedHighlight = NO; 
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

- (PotentialBond *)currentlyHighlightedPotentialBond {
	return [potentialBondMap currentlyHighlightedPotentialBond];
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
		[self renderPotentialBondMap:ctx];
		
	}
	
	return;
	
}

- (void) addConnectingBond:(Bond *)bond {
	[connectingBonds addBond:bond];
}

- (BOOL) hasBondToTheNorth {
	for(Bond *bond in connectingBonds) {
		if([bond hasNodeToNorthOfNode:self]) {
			return true;
		}
	}
			
	return false;	
}

- (BOOL) hasBondToTheEast {
	for(Bond *bond in connectingBonds) {
		if([bond hasNodeToEastOfNode:self]) {
			return true;
		}
	}
			
	return false;	
}
- (BOOL) hasBondToTheSouth {
	for(Bond *bond in connectingBonds) {
		if([bond hasNodeToSouthOfNode:self]) {
			return true;
		}
	}
			
	return false;	
}
- (BOOL) hasBondToTheWest {
	for(Bond *bond in connectingBonds) {
		if([bond hasNodeToWestOfNode:self]) {
			return true;
		}
	}
			
	return false;	
}
			
- (BOOL) isNorthOf:(Node *)node {
	if(yCoord > [node yCoord]) {
		return true;
	}
			
	return false;
}

- (BOOL) isSouthOf:(Node *)node {
	if(yCoord < [node yCoord]) {
		return true;
	}
			
	return false;
}

- (BOOL) isEastOf:(Node *)node {
	if(xCoord > [node xCoord]) {
		return true;
	}
			
	return false;
}

- (BOOL) isWestOf:(Node *)node {
	if(xCoord < [node xCoord]) {
		return true;
	}

	return false;
}

- (void) renderPotentialBondMap:(CGContextRef)ctx {
				
		
		CGPoint startPoint = CGPointMake(xCoord, yCoord);
		
		// every node must be initialized with four potential bonds to start with
		// as carbon nodes can have up to four bonds
		
		if(![self hasBondToTheNorth]) {
			CGPoint bondOnePoint = CGPointMake(xCoord, yCoord + 50);    // north of node
			PotentialBond *bondOne = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:bondOnePoint];
			[potentialBondMap addPotentialBond:bondOne];
		}
		
		if(![self hasBondToTheEast]) {
			CGPoint bondTwoPoint = CGPointMake(xCoord + 50, yCoord);    // east of node
			PotentialBond *bondTwo = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:bondTwoPoint];
			[potentialBondMap addPotentialBond:bondTwo];
		
		}
		
		if(![self hasBondToTheSouth]) {
			CGPoint bondThreePoint = CGPointMake(xCoord, yCoord - 50);  // south of node
			PotentialBond *bondThree = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:bondThreePoint];
			[potentialBondMap addPotentialBond:bondThree];
		}
		
		if(![self hasBondToTheWest]) {
			CGPoint bondFourPoint = CGPointMake(xCoord - 50, yCoord);   // west of node
			PotentialBond *bondFour = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:bondFourPoint];
			[potentialBondMap addPotentialBond:bondFour];
		}
		

		
		[potentialBondMap renderWithContext:ctx];

}
			

- (void) dealloc {
	
	[potentialBondMap release];
	[elementType release];
	[super dealloc];
	
}


@end
