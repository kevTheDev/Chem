//
//  NodeMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NodeMap.h"


@implementation NodeMap

- (NodeMap *) init {
	
	self = [super init];
	
    if ( self ) {
        nodes = [[NSMutableArray alloc] initWithCapacity:5];
    }
	
    return self;
	
}

- (BOOL) isEmpty {
	return [nodes count] == 0;	
}

- (NSUInteger) count {
	return [nodes count];
}

- (void) addNode:(Node *)node {
	[nodes addObject:node];
}

@end
