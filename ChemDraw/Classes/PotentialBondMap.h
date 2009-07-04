//
//  PotentialBondMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PotentialBond;

@interface PotentialBondMap : NSObject {
	NSMutableArray *bonds;
}

- (void) renderWithContext:(CGContextRef)ctx;

- (void) addPotentialBond:(PotentialBond *)potentialBond;

- (PotentialBond *) closestBondToPoint:(CGPoint)point;
- (void) highlightClosestPotentialBondToPoint:(CGPoint)point;

- (PotentialBond *)currentlyHighlightedPotentialBond;

@end
