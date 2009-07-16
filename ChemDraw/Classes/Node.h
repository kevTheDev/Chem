//
//  Node.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <ApplicationServices/ApplicationServices.h>

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

- (BOOL) hasBondToTheNorth;
- (BOOL) hasBondToTheEast;
- (BOOL) hasBondToTheSouth;
- (BOOL) hasBondToTheWest;

- (BOOL) hasBondToNorthEast;
- (BOOL) hasBondToNorthWest;
- (BOOL) hasBondToSouthEast;
- (BOOL) hasBondToSouthWest;

- (BOOL) isNorthOf:(Node *)node;
- (BOOL) isSouthOf:(Node *)node;
- (BOOL) isEastOf:(Node *)node;
- (BOOL) isWestOf:(Node *)node;

- (BOOL) isNorthEastOf:(Node *)node;
- (BOOL) isSouthEastOf:(Node *)node;
- (BOOL) isNorthWestOf:(Node *)node;
- (BOOL) isSouthWestOf:(Node *)node;

- (void) renderPotentialBondMap:(CGContextRef)ctx;

@property (nonatomic) CGFloat xCoord;
@property (nonatomic) CGFloat yCoord;

@property (nonatomic) BOOL unconfirmedHighlight;
@property (nonatomic) BOOL confirmedHighlight;

@property (nonatomic) BOOL displayPotentialBondMap;

@property (nonatomic, retain) NSString *elementType;

@end
