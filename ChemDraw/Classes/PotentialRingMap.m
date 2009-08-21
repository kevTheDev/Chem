//
//  PotentialRingMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 21/08/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PotentialRingMap.h"
#import "Bond.h"

@implementation PotentialRingMap

@synthesize ringSize;
@synthesize baseBond;

- (PotentialRingMap *) initWithRingSize:(NSInteger)ringNumber andBaseBond(Bond *)bond {
	
	self = [super init];
	
    if ( self ) {
        self.ringSize = ringNumber;
		self.baseBond = bond;
    }	
    return self;	
}

- (void) dealloc {

}

- (void) renderWithContext:(CGContextRef)ctx {
	
}

@end
