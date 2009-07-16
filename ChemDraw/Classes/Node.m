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
		
		CGPoint southWestPoint = CGPointMake(xCoord + SOUTH_WEST_X, yCoord + SOUTH_WEST_Y);
		PotentialBond *southWestBond = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:southWestPoint];
		
		CGPoint southEastPoint = CGPointMake(xCoord + SOUTH_EAST_X, yCoord + SOUTH_EAST_Y);   
		PotentialBond *southEastBond = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:southEastPoint];
		
		CGPoint westPoint = CGPointMake(xCoord + WEST_X, yCoord + WEST_Y);    
		PotentialBond *westBond = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:westPoint];

		CGPoint southPoint = CGPointMake(xCoord + SOUTH_X, yCoord + SOUTH_Y); 
		PotentialBond *southBond = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:southPoint];
		
		CGPoint northWestPoint = CGPointMake(xCoord + NORTH_WEST_X, yCoord + NORTH_WEST_Y);
		PotentialBond *northWestBond = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:northWestPoint];

		CGPoint northPoint = CGPointMake(xCoord + NORTH_X, yCoord + NORTH_Y); 
		PotentialBond *northBond = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:northPoint];
		
		CGPoint northEastPoint = CGPointMake(xCoord + NORTH_EAST_X, yCoord + NORTH_EAST_Y); 
		PotentialBond *northEastBond = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:northEastPoint];
		
		CGPoint eastPoint = CGPointMake(xCoord + EAST_X, yCoord + EAST_Y);    // north of node
		PotentialBond *eastBond = [[PotentialBond alloc] initWithStartPoint:startPoint endPoint:eastPoint];
		
		// every node must be initialized with four potential bonds to start with
		// as carbon nodes can have up to four bonds
		if([self hasBondToTheNorth]) {			
			[potentialBondMap addNewPotentialBond:southWestBond];			
			[potentialBondMap addNewPotentialBond:southEastBond];
		}
		
		if([self hasBondToNorthEast]) {			
			[potentialBondMap addNewPotentialBond:westBond];			
			[potentialBondMap addNewPotentialBond:southBond];
		}

		
		if([self hasBondToTheEast]) {
			[potentialBondMap addNewPotentialBond:southWestBond];
			[potentialBondMap addNewPotentialBond:northWestBond];
		}
		
		if([self hasBondToSouthEast]) {
			[potentialBondMap addNewPotentialBond:westBond];
			[potentialBondMap addNewPotentialBond:northBond];
		}
		
		if([self hasBondToTheSouth]) {
			
			[potentialBondMap addNewPotentialBond:northEastBond];
			[potentialBondMap addNewPotentialBond:northWestBond];
		}
		
		if([self hasBondToSouthWest]) {
			[potentialBondMap addNewPotentialBond:northBond];			
			[potentialBondMap addNewPotentialBond:eastBond];
		}		
		
		if([self hasBondToTheWest]) { // if bond to the west then draw to NE and SE
			[potentialBondMap addNewPotentialBond:northEastBond];			
			[potentialBondMap addNewPotentialBond:southEastBond];

		}		
		
		if([self hasBondToNorthWest]) {
			[potentialBondMap addNewPotentialBond:southBond];			
			[potentialBondMap addNewPotentialBond:eastBond];		
		}
		
		[northBond release];
		[eastBond release];
		[southBond release];
		[westBond release];
		
		[northEastBond release];
		[northWestBond release];
		[southEastBond release];
		[southWestBond release];
		
		[potentialBondMap renderWithContext:ctx];

}
			
- (void) clearPotentialBondMap {
	[potentialBondMap reset];
}

- (void) dealloc {
	
	[potentialBondMap release];
	[elementType release];
	[super dealloc];
	
}


@end
