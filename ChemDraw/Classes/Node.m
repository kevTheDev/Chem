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
		
		elementType = @"C";
		
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
	
	[potentialBondMap reset];
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
	
	return [Arithmetic roundFloatDownToInteger:xCoord];
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
	
	
	if(elementType != NULL) {
		CGContextSelectFont(ctx, "Helvetica", 14.0, kCGEncodingMacRoman);
		CGContextSetTextDrawingMode(ctx, kCGTextFill);
		CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
	
		CGAffineTransform xform = CGAffineTransformMake(
													1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
		CGContextSetTextMatrix(ctx, xform);
	
		//NSString* nString = @"Test";
		char cString[10];
 
		//Convert from NSString to char*
		[elementType getCString:cString maxLength:(sizeof cString) encoding:NSUTF8StringEncoding];

	
	
		CGContextShowTextAtPoint(ctx, xCoord + 6, yCoord - 6, cString, strlen(cString));
	
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

- (BOOL) hasBondToNorthEast {
	for(Bond *bond in connectingBonds) {
		if([bond hasNodeToNorthEastOfNode:self]) {
			return true;
		}
	}
	return false;	
}

- (BOOL) hasBondToNorthWest  {
	for(Bond *bond in connectingBonds) {
		if([bond hasNodeToNorthWestOfNode:self]) {
			return true;
		}
	}
	return false;	
}

- (BOOL) hasBondToSouthEast  {
	for(Bond *bond in connectingBonds) {
		if([bond hasNodeToSouthEastOfNode:self]) {
			return true;
		}
	}
	return false;	
}

- (BOOL) hasBondToSouthWest  {
	for(Bond *bond in connectingBonds) {
		if([bond hasNodeToSouthWestOfNode:self]) {
			return true;
		}
	}
	return false;	
}
			
- (BOOL) isNorthOf:(Node *)node {
	if(yCoord < [node yCoord]) {
		return true;
	}
			
	return false;
}

- (BOOL) isSouthOf:(Node *)node {
	if(yCoord > [node yCoord]) {
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

- (BOOL) isNorthEastOf:(Node *)node {
	return ([self isNorthOf:node] && [self isEastOf:node]);
}

- (BOOL) isSouthEastOf:(Node *)node {
	return ([self isSouthOf:node] && [self isEastOf:node]);
}

- (BOOL) isNorthWestOf:(Node *)node {
	return ([self isNorthOf:node] && [self isWestOf:node]);
}

- (BOOL) isSouthWestOf:(Node *)node {
	return ([self isSouthOf:node] && [self isWestOf:node]);
}



- (void) renderPotentialBondMap:(CGContextRef)ctx {
				
		
		CGPoint startPoint = CGPointMake(xCoord, yCoord);
		
		// every node must be initialized with four potential bonds to start with
		// as carbon nodes can have up to four bonds
		
		if([self hasBondToNorthEast] == NO) {
			CGPoint bondOnePoint = CGPointMake(xCoord + NEW_BOND_X_DIFFERENCE, yCoord - NEW_BOND_Y_DIFFERENCE);    // north of node
			PotentialBond *bondOne = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:bondOnePoint];
			[potentialBondMap addPotentialBond:bondOne];
		}
		
		if([self hasBondToNorthWest] == NO) {
			CGPoint bondTwoPoint = CGPointMake(xCoord - NEW_BOND_X_DIFFERENCE, yCoord - NEW_BOND_Y_DIFFERENCE);    // east of node
			PotentialBond *bondTwo = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:bondTwoPoint];
			[potentialBondMap addPotentialBond:bondTwo];
		
		}
		
		if([self hasBondToSouthEast] == NO) {
			CGPoint bondThreePoint = CGPointMake(xCoord + NEW_BOND_X_DIFFERENCE, yCoord + NEW_BOND_Y_DIFFERENCE);  // south of node
			PotentialBond *bondThree = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:bondThreePoint];
			[potentialBondMap addPotentialBond:bondThree];
		}
		
		if([self hasBondToSouthWest] == NO) {
			CGPoint bondFourPoint = CGPointMake(xCoord - NEW_BOND_X_DIFFERENCE, yCoord + NEW_BOND_Y_DIFFERENCE);   // west of node
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
