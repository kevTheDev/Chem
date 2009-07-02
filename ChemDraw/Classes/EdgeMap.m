//
//  EdgeMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 30/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EdgeMap.h"


@implementation EdgeMap


- (EdgeMap *) init {
	
	self = [super init];
	
    if ( self ) {
        edges = [[NSMutableArray alloc] initWithCapacity:5];
    }
	
    return self;
	
}

- (NSUInteger) count {
	return [edges count];
}

- (BOOL) isEmpty {
	return [edges count] == 0;	
}

- (void) addEdge:(Edge *)edge {
	[edges addObject:edge];
}

- (void)dealloc {
	[edges release];
    [super dealloc];
}

@end
