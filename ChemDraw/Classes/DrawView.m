//
//  DrawView.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DrawView.h"

@class ProgramState;
@class ObjectMap;
@class Node;
@class Bond;


@implementation DrawView

char* screenState = "start";

// this init method never seems to really get called
- (id)initWithFrame:(CGRect)frame {
		
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		
    }
	
		
    return self;
}

- (IBAction)makeDoubleBond:(id)sender {
	NSLog(@"DOUBLE BOND PRESSED");
	
	Bond *selectedBond = [objectMap currentlySelectedBond];
	
	NSLog(@"IS BOND DOUBLE?: %d", [selectedBond isDouble]);
	
	
	[selectedBond setIsDouble:YES];
	
	NSLog(@"IS BOND DOUBLE?: %d", [selectedBond isDouble]);
	[toolBar removeFromSuperview];
	
	[objectMap clearSelectedBonds];
	
	screenState = "secondNode";
	[self setNeedsDisplay]; // redraw entire screen
	
	
	
}

- (IBAction)addNewNode:(id)sender {
	
	screenState = "secondNode";
	
	
	[toolBar removeFromSuperview];
	//[self setNeedsDisplay]; // redraw entire screen
}


- (void)drawRect:(CGRect)rect {
	
	[toolBar removeFromSuperview];
	
	if(programState == NULL) {
		programState = [[ProgramState alloc] init];	
	}
	
	// init toolbar buttons arrays
	if([bondButtons count] == 0) {
		
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		[tempArray addObject:doubleBondButton];
		
		bondButtons = [[NSArray alloc] initWithArray:tempArray];
		
		[tempArray release];
		
	}
	
	if([nodeButtons count] == 0) {
		
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		[tempArray addObject:addNodeButton];
		
		nodeButtons = [[NSArray alloc] initWithArray:tempArray];
		
		[tempArray release];
		
	}
	
    // Drawing code
	[[UIColor whiteColor] setFill]; 
	UIRectFill(rect);
	
	// got the graphics context
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	NSLog(@"PROG STATE: %s", [programState currentPrompt]);
	
	char* text = "";
	
	NSLog(@"SCREEN STATE: %s", screenState);
	
	if(screenState == "start") {
		text = "Touch the screen to create the first root node...";
		
		objectMap = [[ObjectMap alloc] init];

		screenState = "firstNode";
	}
	else if(screenState == "firstNode") {
		text = "Touch the screen again to form an bond...";
		screenState = "secondNode";
	}
	else if(screenState == "secondNode") {
		text = "Touch near an bond or node to manipulate it...";
		
		Node *firstNode;
		Node *secondNode;
		
		NSObject *selectedObject = [objectMap currentlySelectedObject];
		if((selectedObject != NULL) && [selectedObject isKindOfClass:[Node class]]) {
			firstNode = (Node *) selectedObject;
			
			int secondNodeIndex = [objectMap nodesCount] - 1;
			secondNode = [objectMap nodeAtIndex:secondNodeIndex];
			
			[objectMap clearSelectedNodes];
		}
		else {
			firstNode = [objectMap nodeAtIndex:0];
			secondNode = [objectMap nodeAtIndex:1];
		}

		
		Bond *bond = [[Bond alloc] initWithNodeA:firstNode nodeB:secondNode];
		[objectMap addBond:bond];
		[bond release];
		
		screenState = "main";
		
	}
	else if(screenState == "main") {
		if([objectMap highlightedNodesCount] > 0 && [objectMap highlightedBondsCount] > 0) {
			text = "Confirm an bond or a node";
		}
		else if([objectMap highlightedBondsCount] > 0) {
			text = "Confirm an bond";
		}
		else if([objectMap highlightedNodesCount] > 0) {
			text = "Confirm a node";
		}
		else {
			text = "No unconfirmed objects";
		}

		screenState = "confirm";
		
	}
	else {
		NSLog(@"SCREEN STATE CONFIRM");
		
		NSObject *selectedObject = [objectMap currentlySelectedObject];
		if([selectedObject isKindOfClass:[Node class]]) {
			[toolBar setItems:nodeButtons];
		}
		else {
			[toolBar setItems:bondButtons];
		}
		
		[self addSubview:toolBar];
	}
	
	[self renderText:text withXCoord:15.0 withYCoord:50.0 withContext:(CGContextRef)ctx];
	[objectMap renderWithContext:ctx];

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
	else if(screenState == "firstNode" || screenState == "secondNode") {
		NSLog(@"TOUCH BEGAN WITH SCREEN STATE: %s", screenState);
		
		// create a node and add it to the object map
		Node *node = [[Node alloc] initWithXCoord:pos.x yCoord:pos.y];	
		[objectMap addNode:node];		
		[node release]; //release temp node object
	}
	
	
	
	[self setNeedsDisplay]; // redraw entire screen
	
	return;
}

- (void) renderText:(char *)text withXCoord:(CGFloat)xCoord withYCoord:(CGFloat)yCoord withContext:(CGContextRef)ctx {
	
	CGContextSelectFont(ctx, "Helvetica", 14.0, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(ctx, kCGTextFill);
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
	
    CGAffineTransform xform = CGAffineTransformMake(
													1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
    CGContextSetTextMatrix(ctx, xform);
	
	
    CGContextShowTextAtPoint(ctx, xCoord, yCoord, text, strlen(text));
	
	return;
}


- (void)dealloc {
	[programState release];
	[objectMap release];
    [super dealloc];
}


@end
