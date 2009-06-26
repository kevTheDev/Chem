//
//  Node.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Node.h"



@implementation Node

@synthesize xCoord;
@synthesize yCoord;
@synthesize unconfirmedHighlight;
@synthesize confirmedHighlight;

- (Node *) initWithXCoord:(CGFloat)x yCoord:(CGFloat)y {
	
	self = [super init];
	
    if ( self ) {
        [self setXCoord:x];
		[self setYCoord:y];
    }
	
    return self;
	
}

- (NSUInteger)hash {

	NSString *hashValue = [NSString stringWithFormat:@"%f%f", [self xCoord], [self yCoord]];
	return [hashValue intValue];
}

- (BOOL)isEqual:(id)anObject {
	
	if( [anObject xCoord] == [self xCoord] && [anObject yCoord] == [self yCoord] ) {
		return true;
	}

	return false;
}

@end
