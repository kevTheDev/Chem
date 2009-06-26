//
//  DrawView.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DrawView.h"

@class Node;

@implementation DrawView

@synthesize firstNode;
@synthesize secondNode;
@synthesize nodes;

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
	
	
	if(screenState == "start") {
		text = "Touch the screen to create the first root node...";
		NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:10];
		
		NSLog(@"INIT NODES");
		[self setNodes:tempArray];
		
		screenState = "init";
	}
	else if(screenState == "firstNode") {
		text = "Touch the screen again to form an edge...";
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

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];

	CGPoint	pos = [touch locationInView:self];

	Node *node = [[Node alloc] initWithXCoord:pos.x yCoord:pos.y];
	[[self nodes] addObject:node];

	
	[node release]; //release temp node object
	
	[self setNeedsDisplay]; // redraw entire screen
	
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

- (void) drawNode:(Node *)node {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(ctx, 255, 0, 0, 1.0);
    CGContextFillEllipseInRect(ctx, CGRectMake([node xCoord], [node yCoord], touchWidth, touchHeight));
	return;
	
}

- (void)dealloc {
	[nodes release];
    [super dealloc];
}


@end
