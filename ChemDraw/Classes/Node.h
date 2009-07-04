//
//  Node.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Arithmetic;
@class PotentialBond;
@class PotentialBondMap;

@class Bond;
@class BondMap;

@interface Node : NSObject {
	CGFloat xCoord;
	CGFloat yCoord;
	
	BOOL unconfirmedHighlight;
	BOOL confirmedHighlight;
	
	BOOL displayPotentialBondMap;
	
	NSString *elementType;
	
	BondMap *connectingBonds;
	PotentialBondMap *potentialBondMap;
}

- (Node *) initWithXCoord:(CGFloat)x yCoord:(CGFloat)y;

- (int) xCoordForHash;
- (int) yCoordForHash;

- (void) highlight;
- (BOOL) isHighlighted;

- (void) select;
- (void) deSelect;
- (BOOL) isSelected;

- (void) renderWithContext:(CGContextRef)ctx;

- (void) highlightClosestPotentialBondToPoint:(CGPoint)point;
- (PotentialBond *)currentlyHighlightedPotentialBond;

- (void) addConnectingBond:(Bond *)bond;

@property CGFloat xCoord;
@property CGFloat yCoord;

@property BOOL unconfirmedHighlight;
@property BOOL confirmedHighlight;

@property BOOL displayPotentialBondMap;

@property (nonatomic, retain) NSString *elementType;

@end
