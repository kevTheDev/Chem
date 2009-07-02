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
@synthesize nodeAPoint;
@synthesize nodeBPoint;
@synthesize centerPoint;

@synthesize unconfirmedHighlight;
@synthesize confirmedHighlight;

- (Edge *) initWithNodeA:(Node *)firstNode nodeB:(Node *)secondNode {
	self = [super init];
	
	if ( self ) {
        [self setNodeA:firstNode];
		[self setNodeB:secondNode];
		
		Node *tempNode = [self centerPointNode];
		CGPoint tempPoint = CGPointMake(tempNode.xCoord, tempNode.yCoord);
		[self setCenterPoint:tempPoint];
		[tempNode release];
		
		CGPoint tempPointOne = CGPointMake(firstNode.xCoord, firstNode.yCoord);
		CGPoint tempPointTwo = CGPointMake(secondNode.xCoord, secondNode.yCoord);
		
		[self setNodeAPoint:tempPointOne];
		[self setNodeBPoint:tempPointTwo];
		
		//[self setCenterNode:[self centerPointNode]];
    }
	
    return self;
}

- (void) select {
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

- (Node *) centerNode {
	return [self centerPointNode];
}

// returns a node object that contains the x and y points of the center point of the edge
- (Node *) centerPointNode {
	
	NSLog(@"CENTER POINT NODE 1");
	float nodeAX = [nodeA xCoord];
	NSLog(@"CENTER POINT NODE 2");	
	float nodeBX = [nodeB xCoord];
	
	NSLog(@"CENTER POINT NODE 3");	
	
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

- (NSUInteger)hash {
	
	//Node *selfCenter = [self centerPointNode];
	
	//NSString *hashValue = [NSString stringWithFormat:@"%f%f", [selfCenter xCoord], [selfCenter yCoord]];
	
	NSString *hashString = [NSString stringWithFormat:@"%d%d", [nodeA hash], [nodeB hash]];
	
	return [hashString intValue];
}

- (BOOL)isEqual:(id)anObject {
	
	if([anObject class] != [self class]) {
		return false;
	}
	
	Node *anObjectNodeA = [anObject nodeA];
	Node *anObjectNodeB = [anObject nodeB];
	
	if([[self nodeA] isEqual:anObjectNodeA] && [[self nodeB] isEqual:anObjectNodeB]) {
		return YES;		
	}
	
	if([[self nodeA] isEqual:anObjectNodeB] && [[self nodeB] isEqual:anObjectNodeA]) {
		return YES;		
	}
	
	return false;
}

- (void) dealloc {
	
	[nodeA release];
	[nodeB release];
	//[centerNode release];
	[super dealloc];
	
}

@end
