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

int touchX;
int touchY;
int touchWidth;
int touchHeight;



char* screenState = "start";

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		//firstNode = [Node alloc];
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
	
    [self drawNode:firstNode];
	[self drawNode:secondNode];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"TOUCH!");
	
	UITouch *touch = [touches anyObject];

	CGPoint	pos = [touch locationInView:self];
	
	touchWidth = 10;
	touchHeight = 10;
	
	
	Node *node = [[Node alloc] initWithXCoord:pos.x yCoord:pos.y];
	
	
	if(screenState == "firstNode") {
		screenState == "secondNode";
		[self setSecondNode:node];
	}
	else {
    	screenState = "firstNode";
		[self setFirstNode:node];
	}
	
	
	
	[self setNeedsDisplay];
	
	//[firstNode release];
	
	return;
}

- (void) drawNode:(Node *)node {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(ctx, 255, 0, 0, 1.0);
    CGContextFillEllipseInRect(ctx, CGRectMake([node xCoord], [node yCoord], touchWidth, touchHeight));
	return;
	
}

-(CGPathRef) pathInRect:(CGRect)rect { 
	CGMutablePathRef path = CGPathCreateMutable(); 
	CGFloat radius = CGRectGetHeight(rect) / 2.0f; 
	CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect)); 
	CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect) - radius, 
						 CGRectGetMinY(rect)); 
	CGPathAddArc(path, NULL, CGRectGetMaxX(rect) - radius, 
				 CGRectGetMinY(rect) + radius, 
				 radius, -M_PI, M_PI, NO); 
	CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect)); 
	CGPathCloseSubpath(path); 
	CGPathRef imutablePath = CGPathCreateCopy(path); 
	CGPathRelease(path); 
	return imutablePath; 
} 



- (void)dealloc {
	[firstNode release];
    [super dealloc];
}


@end
