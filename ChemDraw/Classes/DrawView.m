//
//  DrawView.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DrawView.h"

@class ObjectMap;
@class Node;
@class Edge;

@implementation DrawView


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
		
		objectMap = [[ObjectMap alloc] init];

		screenState = "firstNode";
	}
	else if(screenState == "firstNode") {
		text = "Touch the screen again to form an edge...";
		screenState = "secondNode";
	}
	else if(screenState == "secondNode") {
		text = "Touch near an edge or node to manipulate it...";

		Node *firstNode = [objectMap nodeAtIndex:0];
		Node *secondNode = [objectMap nodeAtIndex:1];
		
		NSLog(@"FIRST NODE X: %f", [firstNode xCoord]);
		NSLog(@"SECOND NODE X: %f", [secondNode xCoord]);
		
		Edge *edge = [[Edge alloc] initWithNodeA:firstNode nodeB:secondNode];
		[objectMap addEdge:edge];
		[edge release];
		
		screenState = "main";
		
	}
	else if(screenState == "main") {
		if([objectMap highlightedNodesCount] > 0 && [objectMap highlightedEdgesCount] > 0) {
			text = "Confirm an edge or a node";
		}
		else if([objectMap highlightedEdgesCount] > 0) {
			text = "Confirm an edge";
		}
		else if([objectMap highlightedNodesCount] > 0) {
			text = "Confirm a node";
		}
		else {
			text = "No unconfirmed objects";
			NSLog(@"No unconfirmed objects");
		}

		
		screenState = "confirm";
		
	}
	else {
		NSLog(@"SCREEN STATE CONFIRM");
	}
	
    CGContextSelectFont(ctx, "Helvetica", 14.0, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(ctx, kCGTextFill);
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
	
    CGAffineTransform xform = CGAffineTransformMake(
													1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
    CGContextSetTextMatrix(ctx, xform);
	
	NSLog(@"HELLO THERE");
	
    CGContextShowTextAtPoint(ctx, 15, 50, text, strlen(text));
	NSLog(@"RENDERED TEXT");
	
	//if([objectMap edgesCount] == 0) {
		[self renderNodes];
	//}
	
	NSLog(@"RENDERED NODES");
	[self renderEdges];
	NSLog(@"RENDERED EDGES");

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint	pos = [touch locationInView:self];

	NSLog(@"TOUCH BEGAN WITH SCREEN STATE: %s", screenState);
	
	if(screenState == "main") {

		[objectMap highlightClosestObjectToPoint:pos];
	
	}
	else if(screenState == "confirm") {
		
		// detect a user confirming a highlighted object
		[objectMap selectClosestObjectToPoint:pos];
		NSLog(@"SELECTED CLOSEST OBJECT");
	}
	else {
		// create a node and add it to the object map
		Node *node = [[Node alloc] initWithXCoord:pos.x yCoord:pos.y];	
		[objectMap addNode:node];		
		[node release]; //release temp node object
	}
	
	
	
	[self setNeedsDisplay]; // redraw entire screen
	
	return;
}


// draw all nodes
- (void) renderNodes {
	
	
	
	//for (Node *node in [objectMap nodeMap])
//	{
//		// do things here
//		[self drawNode:node];
//	}
	
	[self renderPlainNodes];
	[self renderSelectedNodes];
	[self renderHighlightedNodes];
	
	return;
}

- (void) renderPlainNodes {
	return;
}

- (void) renderHighlightedNodes {
	for (Node *node in [objectMap highlightedNodes]) {
		[self drawNode:node];
	}
	return;
}

- (void) renderSelectedNodes {
	for (Node *node in [objectMap selectedNodes]) {
		[self drawNode:node];
	}
	return;
}

- (void) renderEdges {

	[self renderPlainEdges];
	[self renderHighlightedEdges];
	[self renderSelectedEdges];
	return;
}

- (void) renderPlainEdges {
	return;
}

- (void) renderHighlightedEdges {
	for (Edge *edge in [objectMap highlightedEdges]) {
		[self drawEdge:edge];
	}
	return;
}


- (void) renderSelectedEdges {
	for (Edge *edge in [objectMap selectedEdges]) {
		[self drawEdge:edge];
	}
	return;
}

- (void) drawEdge:(Edge *)edge {
	
	NSLog(@"DRWA THE EDGE 1");
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	NSLog(@"DRWA THE EDGE 2");
	CGMutablePathRef path = CGPathCreateMutable();
	
	//Node *firstNode = [edge nodeA];
	//Node *secondNode = [edge nodeB];
	
	CGPoint nodeAPoint = [edge nodeAPoint];
	CGPoint nodeBPoint = [edge nodeBPoint];
	
	NSLog(@"DRWA THE EDGE 3");

	
	NSLog(@"SECOND NODE X: %f", nodeAPoint.x);
	
	CGPathMoveToPoint(path, NULL, nodeAPoint.x + 5.0, nodeAPoint.y + 5.0);
	
	NSLog(@"DRWA THE EDGE 4");
	
	CGPathAddLineToPoint(path, NULL, nodeBPoint.x + 5.0, nodeBPoint.y + 5.0);
	
	NSLog(@"DRWA THE EDGE 5");
	
	CGPathCloseSubpath(path);
	CGContextAddPath(ctx, path);
	
	NSLog(@"DRWA THE EDGE 1");
	
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
	
	[self drawNodePoint:nodeAPoint];
	[self drawNodePoint:nodeBPoint];
	
	return;
}

- (void) drawNodePoint:(CGPoint)nodePoint {
	CGContextRef ctx = UIGraphicsGetCurrentContext();

	CGContextSetRGBFillColor(ctx, 255, 0, 0, 1.0);
	
    CGContextFillEllipseInRect(ctx, CGRectMake(nodePoint.x, nodePoint.y, NODE_WIDTH, NODE_HEIGHT));
	
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


- (void)dealloc {
	[objectMap release];
	//[nodes release];
    [super dealloc];
}


@end
