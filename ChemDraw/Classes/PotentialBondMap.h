//
//  PotentialBondMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PotentialBond.h"

@interface PotentialBondMap : NSObject {
	NSMutableArray *bonds;
}

- (void) renderWithContext:(CGContextRef)ctx;

- (void) addPotentialBond:(PotentialBond *)potentialBond;

@end
