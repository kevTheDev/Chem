//
//  DoubleBondAction.m
//  ChemDraw
//
//  Created by Kevin Edwards on 16/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DoubleBondAction.h"
#import "Bond.h"

@implementation DoubleBondAction

- (DoubleBondAction *) initWithBond:(Bond *)initBond {
	self = [super init];
	
	if(self) {
		bond = initBond;
	}	
	return self;
}

- (void) undo {
	[bond makeSingle];
}

@end
