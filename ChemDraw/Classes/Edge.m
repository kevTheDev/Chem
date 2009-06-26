//
//  Edge.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Edge.h"


@implementation Edge

@synthesize nodeA;
@synthesize nodeB;

- (Edge *) initWithNodeA:(Node *)firstNode nodeB:(Node *)secondNode {
	self = [super init];
	
	if ( self ) {
        [self setNodeA:firstNode];
		[self setNodeB:secondNode];
    }
	
    return self;
}


@end
