//
//  TripleBondAction.m
//  ChemDraw
//
//  Created by Kevin Edwards on 16/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TripleBondAction.h"
#import "Bond.h"

@implementation TripleBondAction

- (TripleBondAction *) initWithBond:(Bond *)initBond {
	self = [super init];
	
	if(self) {
		bond = initBond;
	}	
	return self;
}

- (void) undo {
	[bond makeDouble];
}

@end
