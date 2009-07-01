//
//  DrawView.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DrawView.h"

@class Node;
@class Edge;

@implementation DrawView

@synthesize nodes;
@synthesize edges;
@synthesize unconfirmedHighlightedNodes;
@synthesize unconfirmedHighlightedEdges;

int NODE_WIDTH = 10;
int NODE_HEIGHT = 10;

char* screenState = "start";

- (id)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
	
		
    return self;
}


- (void)drawRect:(CGRect)rect {

    // Drawing code
	[[UIColor whiteColor] setFill]; 
	UIRectFill(rect);
	
	// got the graphics context
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	char* text = "";
	
	NSLog(@"SCREEN STATE: %s", screenState);
	
	if(screenState == "start") {
		text = "Touch the screen to create the first root node...";

		[self setNodes:[[NSMutableArray alloc] initWithCapacity:10]];
		[self setEdges:[[NSMutableArray alloc] initWithCapacity:10]];
		[self setUnconfirmedHighlightedEdges:[[NSMutableArray alloc] initWithCapacity:10]];
		[self setUnconfirmedHighlightedNodes:[[NSMutableArray alloc] initWithCapacity:10]];

		screenState = "firstNode";
	}
	else if(screenState == "firstNode") {
		text = "Touch the screen again to form an edge...";
		screenState = "secondNode";
	}
	else if(screenState == "secondNode") {
		text = "Touch near an edge or node to manipulate it...";
		
		
		Node *firstNode = [[self nodes] objectAtIndex:0];
		Node *secondNode = [[self nodes] objectAtIndex:1];
		
		Edge *edge = [[Edge alloc] initWithNodeA:firstNode nodeB:secondNode];
		[[self edges] addObject:edge];
		[edge release];
		
		screenState = "main";
		
	}
	else if(screenState == "main") {
		if([[self unconfirmedHighlightedEdges] count] > 0 && [[self unconfirmedHighlightedNodes] count] > 0) {
			text = "Confirm an edge or a node";
		}
		else if([[self unconfirmedHighlightedEdges] count] > 0) {
			text = "Confirm an edge";
		}
		else if([[self unconfirmedHighlightedNodes] count] > 0) {
			text = "Confirm a node";
		}
		else {
			text = "No unconfirmed objects";
			NSLog(@"No unconfirmed objects");
		}
		
		NSLog(@"H NODES COUNT: %d", [[self unconfirmedHighlightedNodes] count]);
		NSLog(@"H EDGES COUNT: %d", [[self unconfirmedHighlightedEdges] count]);
		
		screenState = "confirm";
		
	}
	else {
		//NSLog(@"Invalid screen state");
	}
	
    CGContextSelectFont(ctx, "Helvetica", 14.0, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(ctx, kCGTextFill);
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
	
    CGAffineTransform xform = CGAffineTransformMake(
													1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
    CGContextSetTextMatrix(ctx, xform);
	
    CGContextShowTextAtPoint(ctx, 15, 50, text, strlen(text));

	[self renderNodes];
	[self renderEdges];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint	pos = [touch locationInView:self];

	if(screenState == "main") {
		Node *closestNode = [self detectNodesForPoint:pos];
		[self detectClosestEdgesToPoint:pos withClosestNode:closestNode];
		
			
	}
	else if(screenState == "confirm") {
		
		// detect a user confirming a highlighted object
		
		if([[self unconfirmedHighlightedEdges] count] > 0 && [[self unconfirmedHighlightedNodes] count] > 0) {
			
			// EDGE CASE - TODO
		}
		else if([[self unconfirmedHighlightedEdges] count] > 0) {
			[self confirmEdgeFromHighlightedEdges:pos];
		}
		else if([[self unconfirmedHighlightedNodes] count] > 0) {
			[self confirmNodeFromHighlightedNodes:pos];
			
		}
		else {
			NSLog(@"No unconfirmed objects");
		}
	}
	else {
		Node *node = [[Node alloc] initWithXCoord:pos.x yCoord:pos.y];
		[[self nodes] addObject:node];
		[node release]; //release temp node object
	}
	
	
	
	[self setNeedsDisplay]; // redraw entire screen
	
	return;
}

- (Node *) detectNodesForPoint:(CGPoint)point {
	
	Node *tempNode = [Node alloc];
	
	int closestNodeIndex = 0;
	float currentShortestDistance = 0;
	
	for(int i=0; i<[[self nodes] count]; i++)
	{
		tempNode = [[self nodes] objectAtIndex:i];
		
		float xDistance = abs(point.x - [tempNode xCoord]);
		float yDistance = abs(point.y - [tempNode yCoord]);
		
		float newDistance = xDistance + yDistance;
		
		if(currentShortestDistance == 0) {
			currentShortestDistance = newDistance;
		}
		else {
			
			if(newDistance < currentShortestDistance) {
				currentShortestDistance = newDistance;
				closestNodeIndex = i;
			}
			
		}
	}
	
	Node *closestNode = [[self nodes] objectAtIndex:closestNodeIndex];
	[closestNode highlight];
	
	return closestNode;
}

- (void) detectClosestEdgesToPoint:(CGPoint)point withClosestNode:(Node *)closestNode {
	
	Node *tempNode = [Node alloc];
	Edge *tempEdge = [Edge alloc];
	
	int closestEdgeIndex = 0;
	float currentShortestDistance = 0;
	
	for(int i=0; i<[[self edges] count]; i++)
	{
		tempEdge = [[self edges] objectAtIndex:i];
		tempNode = [tempEdge centerNode];
		
		
		float xDistance = abs(point.x - [tempNode xCoord]);
		float yDistance = abs(point.y - [tempNode yCoord]);
		
		float newDistance = xDistance + yDistance;

			
		if(newDistance < currentShortestDistance) {
			currentShortestDistance = newDistance;
			closestEdgeIndex = i;
		}

	}

	Edge *closestEdge = [[self edges] objectAtIndex:closestEdgeIndex];
	
	// find closest out of closest edge and node
	Node *closestEdgeCenterPoint = [tempEdge centerNode];
	
	float edgeXDistance = abs(point.x - [closestEdgeCenterPoint xCoord]);
	float edgeYDistance = abs(point.y - [closestEdgeCenterPoint yCoord]);
	
	float edgeDistance = edgeXDistance + edgeYDistance;
	
	float nodeXDistance = abs(point.x - [closestNode xCoord]);
	float nodeYDistance = abs(point.y - [closestNode yCoord]);
	
	float nodeDistance = nodeXDistance + nodeYDistance;
	
	if(nodeDistance > edgeDistance) {
		[closestNode setUnconfirmedHighlight:NO];
		[closestEdge highlight];
		
		[[self unconfirmedHighlightedEdges] addObject:closestEdge];
	}
	else if(nodeDistance < edgeDistance) {
		[[self unconfirmedHighlightedNodes] addObject:closestNode];
	}
	else if(nodeDistance == edgeDistance) {
		[closestEdge highlight];
		[[self unconfirmedHighlightedEdges] addObject:closestEdge];
		[[self unconfirmedHighlightedNodes] addObject:closestNode];
	}

	
	return;
}

// draw all nodes
- (void) renderNodes {
	
	for (Node *node in [self nodes])
	{
		// do things here
		[self drawNode:node];
	}
	
	return;
}

- (void) renderEdges {
	
	for (Edge *edge in [self edges]) {
		[self drawEdge:edge];
	}
	return;
}

- (void) drawEdge:(Edge *)edge {
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGMutablePathRef path = CGPathCreateMutable();
	
	Node *firstNode = [edge nodeA];
	Node *secondNode = [edge nodeB];
	
	[self drawNode:firstNode];
	[self drawNode:secondNode];
	
	CGPathMoveToPoint(path, NULL, [firstNode xCoord] + 5.0, [firstNode yCoord] + 5.0); 
	CGPathAddLineToPoint(path, NULL, [secondNode xCoord] + 5.0, [secondNode yCoord] + 5.0);
	
	CGPathCloseSubpath(path);
	CGContextAddPath(ctx, path);
	
	if([edge unconfirmedHighlight] == YES) {
		CGContextSetStrokeColorWithColor(ctx, [UIColor purpleColor].CGColor);
	}
	else if([edge confirmedHighlight] == YES) {
		CGContextSetStrokeColorWithColor(ctx, [UIColor orangeColor].CGColor);
	}
	else {
		CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
	}
	CGContextSetLineWidth(ctx, 2.0);
	
	CGContextStrokePath(ctx);
	
	return;
}

- (void) drawNode:(Node *)node {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	if([node confirmedHighlight] == YES) {
		CGContextSetRGBFillColor(ctx, 0, 255, 0, 1.0);
	}
	else if([node unconfirmedHighlight] == YES) {
		CGContextSetRGBFillColor(ctx, 255, 255, 0, 1.0);
	}
	else{
		CGContextSetRGBFillColor(ctx, 255, 0, 0, 1.0);
	}
	
    CGContextFillEllipseInRect(ctx, CGRectMake([node xCoord], [node yCoord], NODE_WIDTH, NODE_HEIGHT));
	return;
	
}

- (Node *) confirmNodeFromHighlightedNodes:(CGPoint)point {
	Node *tempNode = [Node alloc];
	
	int closestNodeIndex = 0;
	float currentShortestDistance = 0;
	
	for(int i=0; i<[[self unconfirmedHighlightedNodes] count]; i++)
	{
		tempNode = [[self unconfirmedHighlightedNodes] objectAtIndex:i];
		
		float xDistance = abs(point.x - [tempNode xCoord]);
		float yDistance = abs(point.y - [tempNode yCoord]);
		
		float newDistance = xDistance + yDistance;
		
		if(currentShortestDistance == 0) {
			currentShortestDistance = newDistance;
		}
		else {
			
			if(newDistance < currentShortestDistance) {
				currentShortestDistance = newDistance;
				closestNodeIndex = i;
			}
			
		}
	}
	
	Node *closestNode = [[self unconfirmedHighlightedNodes] objectAtIndex:closestNodeIndex];
	
	int realNodeIndex = [[self nodes] indexOfObjectIdenticalTo:closestNode];
	
	
	Node *realNode = [[self nodes] objectAtIndex:realNodeIndex];
	
	[realNode confirmSelection];
	
	return closestNode;
	
}

- (Edge *) confirmEdgeFromHighlightedEdges:(CGPoint)point {
	
	Edge *tempEdge = [Edge alloc];
	
	int closestEdgeIndex = 0;
	float currentShortestDistance = 0;
	
	for(int i=0; i<[[self unconfirmedHighlightedEdges] count]; i++)
	{
		tempEdge = [[self unconfirmedHighlightedEdges] objectAtIndex:i];
		
		float xDistance = abs(point.x - [[tempEdge centerNode]xCoord]);
		float yDistance = abs(point.y - [[tempEdge centerNode] yCoord]);
		
		float newDistance = xDistance + yDistance;
		
		if(currentShortestDistance == 0) {
			currentShortestDistance = newDistance;
		}
		else {
			
			if(newDistance < currentShortestDistance) {
				currentShortestDistance = newDistance;
				closestEdgeIndex = i;
			}
			
		}
	}
	
	Node *closestEdge = [[self unconfirmedHighlightedEdges] objectAtIndex:closestEdgeIndex];
	
	int realEdgeIndex = [[self edges] indexOfObjectIdenticalTo:closestEdge];
	
	
	Edge *realEdge = [[self edges] objectAtIndex:realEdgeIndex];
	[realEdge confirmSelection];
	
	return realEdge;
}


- (void)dealloc {
	[nodes release];
    [super dealloc];
}


@end
