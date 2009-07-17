//
//  GestureView.m
//  ChemDraw
//
//  Created by Kevin Edwards on 17/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GestureView.h"

#import "PointObject.h"
#import "PointObjectMap.h"
#import "CharacterMatch.h"

@implementation GestureView

@synthesize matchedCharacter;
@synthesize symbolTimer;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		gesturePoints = [[PointObjectMap alloc] init];		
    }
    return self;
}

- (void)dealloc {
	[symbolTimer release];
	[gesturePoints release];
    [super dealloc];
}


- (void)drawRect:(CGRect)rect {
	NSLog(@"GESTURE DRAW RECT");

    // Drawing code
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	[[UIColor whiteColor] setFill]; 
	UIRectFill(rect);
	
//	NSLog(@"gesture points)
	
	[gesturePoints renderWithContext:ctx];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint	pos = [touch locationInView:self];
	

	PointObject *pointObject = [[PointObject alloc] initWithPoint:pos];
	[gesturePoints addPoint:pointObject];
	
	[self setNeedsDisplay]; // redraw entire screen
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint	pos = [touch locationInView:self];
	
	PointObject *pointObject = [[PointObject alloc] initWithPoint:pos];
	[gesturePoints addPoint:pointObject];
		
	[self setNeedsDisplay];	
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.80 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
	[self setSymbolTimer:timer];
}

// Finished drawing chemical symbol
-(void) onTimer {

	//CharacterMatch *topMatch = [gesturePoints compressPoints];

	//Node *selectedNode = [objectMap currentlySelectedNode];
	//NSString *characterSymbol = [topMatch characterSymbol];
	//[selectedNode setElementType:characterSymbol];
	//[objectMap clearSelectedNodes];
	
	//NSLog(@"NEW ELEMENT TYPE IS: %@", [selectedNode elementType]);

	[symbolTimer invalidate];

	[self setNeedsDisplay]; // redraw entire screen
	
	
	

	
}


@end
