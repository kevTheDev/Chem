//
//  PotentialBondMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

# define NEW_BOND_Y_DIFFERENCE 86.6
# define NEW_BOND_X_DIFFERENCE 50

@class PotentialBond;

@interface PotentialBondMap : NSObject {
	NSMutableArray *bonds;
}

- (void) renderWithContext:(CGContextRef)ctx;

- (void) addPotentialBond:(PotentialBond *)potentialBond;

- (PotentialBond *) closestBondToPoint:(CGPoint)point;
- (void) highlightClosestPotentialBondToPoint:(CGPoint)point;

- (PotentialBond *)currentlyHighlightedPotentialBond;

- (void) reset;

@end
