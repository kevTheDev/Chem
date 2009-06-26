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

int touchWidth = 10;
int touchHeight = 10;

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
//	NSMutableString *text = @""
	
	NSLog(@"SCREEN STATE: %s", screenState);
	
	if(screenState == "start") {
		text = "Touch the screen to create the first root node...";
		NSMutableArray *tempNodesArray = [[NSMutableArray alloc] initWithCapacity:10];
		NSMutableArray *tempEdgesArray = [[NSMutableArray alloc] initWithCapacity:10];
		
		NSLog(@"INIT NODES");
		[self setNodes:tempNodesArray];
		[self setEdges:tempEdgesArray];
		
		[tempNodesArray release];
		[tempEdgesArray release];
		
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
		text = "";
	}
	else {
		NSLog(@"Invalid screen state");
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
		[self detectNodesForPoint:pos];
			
	}
	else {
		Node *node = [[Node alloc] initWithXCoord:pos.x yCoord:pos.y];
		[[self nodes] addObject:node];
		[node release]; //release temp node object
	}
	
	
	
	[self setNeedsDisplay]; // redraw entire screen
	
	return;
}

- (void) detectNodesForPoint:(CGPoint)point {
	
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
	[closestNode setUnconfirmedHighlight:YES];
	
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
	
	CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
	CGContextSetLineWidth(ctx, 2.0);
	
	CGContextStrokePath(ctx);
	
	return;
}

- (void) drawNode:(Node *)node {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	if([node unconfirmedHighlight] == YES) {
		CGContextSetRGBFillColor(ctx, 255, 255, 0, 1.0);
	}
	else{
		CGContextSetRGBFillColor(ctx, 255, 0, 0, 1.0);
	}
	
    CGContextFillEllipseInRect(ctx, CGRectMake([node xCoord], [node yCoord], touchWidth, touchHeight));
	return;
	
}

- (void)dealloc {
	[nodes release];
    [super dealloc];
}


@end
