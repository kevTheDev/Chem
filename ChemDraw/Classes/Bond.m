//
//  Bond.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Bond.h"
#import "Node.h"

@implementation Bond

@synthesize nodeA;
@synthesize nodeB;
@synthesize nodeAPoint;
@synthesize nodeBPoint;
@synthesize centerPoint;

@synthesize unconfirmedHighlight;
@synthesize confirmedHighlight;

@synthesize isDouble;

int LINE_DRAW_WIDTH = 2.0;

- (Bond *) initWithNodeA:(Node *)firstNode nodeB:(Node *)secondNode {
	self = [super init];
	
	if ( self ) {
		
		nodeA = firstNode;
		nodeB = secondNode;
		
		Node *tempNode = [self centerPointNode];
		centerPoint = CGPointMake(tempNode.xCoord, tempNode.yCoord);
		[tempNode release];
		
		
		// create these structs for optimal drawing - quicker than drawing nodes
		nodeAPoint = CGPointMake(firstNode.xCoord, firstNode.yCoord);
		nodeBPoint = CGPointMake(secondNode.xCoord, secondNode.yCoord);

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

// returns a node object that contains the x and y points of the center point of the bond
- (Node *) centerPointNode {
	
	float nodeAX = [nodeA xCoord];
	float nodeBX = [nodeB xCoord];
	
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

- (void) renderWithContext:(CGContextRef)ctx {
	CGMutablePathRef path = CGPathCreateMutable();

	CGPathMoveToPoint(path, NULL, nodeAPoint.x + 5.0, nodeAPoint.y + 5.0);
	CGPathAddLineToPoint(path, NULL, nodeBPoint.x + 5.0, nodeBPoint.y + 5.0);
	CGPathCloseSubpath(path);
	CGContextAddPath(ctx, path);
	

	if([self isHighlighted]) {
		CGContextSetStrokeColorWithColor(ctx, [UIColor purpleColor].CGColor);
	}
	else if([self isSelected]) {
		CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
	}
	else {
		CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
	}
	
	CGContextSetLineWidth(ctx, LINE_DRAW_WIDTH);
	CGContextStrokePath(ctx);
	
	return;
	
}

- (void) dealloc {
	
	[nodeA release];
	[nodeB release];
	[super dealloc];
	
}

@end
