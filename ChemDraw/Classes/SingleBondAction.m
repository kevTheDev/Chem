//
//  SingleBondAction.m
//  ChemDraw
//
//  Created by Kevin Edwards on 16/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SingleBondAction.h"
#import "Bond.h"

@implementation SingleBondAction

- (SingleBondAction *) initWithBond:(Bond *)initBond {
	self = [super init];
	
	if(self) {
		bond = initBond;
	}	
	return self;
}

- (void) undo {
	[bond makeTriple];
}

@end
