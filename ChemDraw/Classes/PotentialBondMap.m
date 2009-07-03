//
//  PotentialBondMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PotentialBondMap.h"


@implementation PotentialBondMap

- (PotentialBondMap *)init {
	self = [super init];
	
	if(self) {
		bonds = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void) renderWithContext:(CGContextRef)ctx {
	for (PotentialBond *bond in bonds) {
		[bond renderWithContext:ctx];
	}
}

@end
