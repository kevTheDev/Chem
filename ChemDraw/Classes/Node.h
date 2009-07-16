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


# define NEW_BOND_Y_DIFFERENCE 86.6
# define NEW_BOND_X_DIFFERENCE 50

# define NORTH_X 0
# define NORTH_Y -100

# define NORTH_EAST_X 50
# define NORTH_EAST_Y -86.6

# define EAST_X 100
# define EAST_Y 0

# define SOUTH_EAST_X 50
# define SOUTH_EAST_Y 86.6

# define SOUTH_X 0
# define SOUTH_Y 100

# define SOUTH_WEST_X -50
# define SOUTH_WEST_Y 86.6

# define WEST_X -100
# define WEST_Y 0

# define NORTH_WEST_X -50
# define NORTH_WEST_Y -86.6

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
