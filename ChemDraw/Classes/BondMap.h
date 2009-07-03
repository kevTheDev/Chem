//
//  BondMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 30/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bond.h"

@interface BondMap : NSObject {
	NSMutableArray *bonds;
}

- (BOOL) isEmpty;
- (void) addBond:(Bond *)bond;
- (NSUInteger) count;


- (Bond *) closestBondToPoint:(CGPoint)point;

- (NSUInteger)indexOfObject:(id)anObject;
- (id)objectAtIndex:(NSUInteger)index;


- (void) highlightBondAtIndex:(NSUInteger)index;
- (void) highlightBond:(Bond *)bond;
- (NSUInteger)highlightedBondsCount;

- (void) selectBondAtIndex:(NSUInteger)index;
- (void) selectBond:(Bond *)bond;
- (NSUInteger)selectedBondsCount;

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len;

- (void) renderWithContext:(CGContextRef)ctx;

@end
