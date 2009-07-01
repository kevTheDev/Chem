//
//  Edge.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Edge.h"
#import "Node.h"


@implementation Edge

@synthesize nodeA;
@synthesize nodeB;
@synthesize centerNode;
@synthesize unconfirmedHighlight;
@synthesize confirmedHighlight;

- (Edge *) initWithNodeA:(Node *)firstNode nodeB:(Node *)secondNode {
	self = [super init];
	
	if ( self ) {
        [self setNodeA:firstNode];
		[self setNodeB:secondNode];
		[self setCenterNode:[self centerPointNode]];
    }
	
    return self;
}

- (void) confirmSelection {
	[self setUnconfirmedHighlight:NO];
	[self setConfirmedHighlight:YES];
}

- (BOOL) isSelected {
	return [self confirmedHighlight];
}

- (void) highlight {
	[self setUnconfirmedHighlight:YES];	
}

- (BOOL) isHighlighted {
	
	return ([self unconfirmedHighlight]);
}

- (NSUInteger)hash {
	
	Node *selfCenter = [self centerPointNode];
	
	NSString *hashValue = [NSString stringWithFormat:@"%f%f", [selfCenter xCoord], [selfCenter yCoord]];
	return [hashValue intValue];
}

- (BOOL)isEqual:(id)anObject {
	
	Node *objectCenter = [anObject centerNode];
	Node *selfCenter = [self centerNode];
	
	if( [objectCenter xCoord] == [selfCenter xCoord] && [objectCenter yCoord] == [selfCenter yCoord] ) {
		return true;
	}
	
	return false;
}

// returns a node object that contains the x and y points of the center point of the edge
- (Node *) centerPointNode {
	
	float nodeAX = [[self nodeA] xCoord];
	float nodeBX = [[self nodeB] xCoord];
	
	float bigX;
	float littleX;
	
	if(nodeAX > nodeBX) {
		bigX = nodeAX;
		littleX = nodeBX;
	}
	else {
		bigX = nodeBX;
		littleX = nodeAX;
	}
	
	float distanceX = bigX - littleX;
	float halfDistanceX = distanceX / 2.0;
	
	float centerX = littleX + halfDistanceX;
	
	float nodeAY = [[self nodeA] yCoord];
	float nodeBY = [[self nodeB] yCoord];
	
	float bigY;
	float littleY;
	
	if(nodeAY > nodeBY) {
		bigY = nodeAY;
		littleY = nodeBY;
	}
	else {
		bigY = nodeAY;
		littleY = nodeBY;
	}
	
	float distanceY = bigY - littleY;
	float halfDistanceY = distanceY / 2.0;
	
	float centerY = littleY + halfDistanceY;
	
	NSLog(@"CENTER EDGE X: %f", centerX);
	NSLog(@"CENTER EDGE Y: %f", centerY);
	
	Node *node = [[Node alloc] initWithXCoord:centerX yCoord:centerY];
	
	return node;
}

- (void) dealloc {
	
	[nodeA release];
	[nodeB release];
	[centerNode release];
	[super dealloc];
	
}

@end
