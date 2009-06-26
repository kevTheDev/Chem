//
//  DrawView.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DrawView.h"


@implementation DrawView


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
	
	char* text = "Touch the screen to create the first root node...";
    CGContextSelectFont(ctx, "Helvetica", 14.0, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(ctx, kCGTextFill);
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
	
    CGAffineTransform xform = CGAffineTransformMake(
													1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
    CGContextSetTextMatrix(ctx, xform);
	
    CGContextShowTextAtPoint(ctx, 15, 50, text, strlen(text));
	
    	

}

- (void) drawNode {
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetRGBFillColor(ctx, 255, 0, 0, 1.0);
    CGContextFillEllipseInRect(ctx, CGRectMake(5, 10, 10, 10));
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
    [super dealloc];
}


@end
