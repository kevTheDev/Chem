//
//  EdgeMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 30/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EdgeMap.h"


@implementation EdgeMap

@synthesize edges;

- (EdgeMap *) initWithCapacity:(int)capacity {
	self = [super init];
	
	
	
	
	
	if ( self ) {
		//[[self edges] initWithCapacity:capacity];		
		//[self setEdges:[[NSMutableArray alloc] initWithCapacity:capacity]];
    }
	
    return self;
}

- (void)dealloc {
	[edges release];
    [super dealloc];
}

@end
