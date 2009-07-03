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
@class PointObject;

@implementation DrawView


// this init method never seems to really get called
- (id)initWithFrame:(CGRect)frame {
		
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		
    }
	
		
    return self;
}

- (IBAction)changeElement:(id)sender {
	NSLog(@"Change element");
	[programState setCurrentState:GESTURE_MODE];
	[self setNeedsDisplay]; // redraw entire screen
	
}

- (IBAction)makeDoubleBond:(id)sender {
	
	Bond *selectedBond = [objectMap currentlySelectedBond];

	[selectedBond setIsDouble:YES];
	
	[toolBar removeFromSuperview];	
	[objectMap clearSelectedBonds];
	
	[programState setCurrentState:SELECT_OBJECT];
	
	[self setNeedsDisplay]; // redraw entire screen
	
	
	
}

- (IBAction)makeSingleBond:(id)sender {
	
	Bond *selectedBond = [objectMap currentlySelectedBond];
	
	[selectedBond setIsDouble:NO];
	
	[toolBar removeFromSuperview];	
	[objectMap clearSelectedBonds];
	
	[programState setCurrentState:SELECT_OBJECT];
	
	[self setNeedsDisplay]; // redraw entire screen
	
	
	
}

- (IBAction)addNewNode:(id)sender {

	[programState setCurrentState:ADD_NODE];
	[toolBar removeFromSuperview];
	[self setNeedsDisplay]; // redraw entire screen
}


- (void)drawRect:(CGRect)rect {

	
	if(programState == NULL) {
		programState = [[ProgramState alloc] init];
		objectMap = [[ObjectMap alloc] init];
		[self setupToolbar];
		[toolBar removeFromSuperview];
		gesturePoints = [[NSMutableArray alloc] init];
	}

	// got the graphics context
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	if([programState currentState] == GESTURE_MODE) {
		[[UIColor whiteColor] setFill]; 
		UIRectFill(rect);
		
		CGPoint point;
		
		for(PointObject *pointObject in gesturePoints) {
			
			NSLog(@"DRAW GESTURE POINT");
			
			point = [pointObject originalPoint];
			[self renderPoint:point withContext:ctx];
				

		}
	}
	else {
		// Drawing code
		[[UIColor whiteColor] setFill]; 
		UIRectFill(rect);
		
		
		
		
		[objectMap renderWithContext:ctx];
	}
   
	char *prompt = [programState currentPrompt];
	[self renderText:prompt withXCoord:15.0 withYCoord:50.0 withContext:(CGContextRef)ctx];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint	pos = [touch locationInView:self];
	
	switch([programState currentState]) {
		case FIRST_NODE:
			NSLog(@"TOUCH BEGAN, SCREEN STATE: FIRST_NODE");
			break;
		case SECOND_NODE:
			NSLog(@"TOUCH BEGAN, SCREEN STATE: SECOND_NODE");
			break;
		case SELECT_OBJECT:
			NSLog(@"TOUCH BEGAN, SCREEN STATE: SELECT_OBJECT");
			break;
		case MANIPULATE_OBJECT:
			NSLog(@"TOUCH BEGAN, SCREEN STATE: MANIPULATE_OBJECT");
			break;
		case ADD_NODE:
			NSLog(@"TOUCH BEGAN, SCREEN STATE: ADD_NODE");
			break;
		case GESTURE_MODE:
			NSLog(@"TOUCH BEGAN, SCREEN STATE: GESTURE_MODE");
			break;
		default:
			NSLog(@"TOUCH BEGAN, SCREEN STATE: NO STATE");
			break;
	}
	
	
	
	if([programState currentState] == FIRST_NODE) {
		
		Node *node = [[Node alloc] initWithXCoord:pos.x yCoord:pos.y];	
		[objectMap addNode:node];		
		[node release]; //release temp node object
		
		[programState setCurrentState:SECOND_NODE];
	}
	else if([programState currentState] == SECOND_NODE) {
		Node *node = [[Node alloc] initWithXCoord:pos.x yCoord:pos.y];	
		[objectMap addNode:node];		
		[node release]; //release temp node object
		
		Node *firstNode = [objectMap nodeAtIndex:0];
		Node *secondNode = [objectMap nodeAtIndex:1];
		
		Bond *bond = [[Bond alloc] initWithNodeA:firstNode nodeB:secondNode];
		[objectMap addBond:bond];
		[bond release];
		
		[programState setCurrentState:SELECT_OBJECT];
	}
	else if([programState currentState] == SELECT_OBJECT) {

		[objectMap highlightClosestObjectToPoint:pos];
		[programState setCurrentState:MANIPULATE_OBJECT];
			
	}
	else if([programState currentState] == MANIPULATE_OBJECT) {
		
		// detect a user confirming a highlighted object
		[objectMap selectClosestObjectToPoint:pos];
		
		NSObject *selectedObject = [objectMap currentlySelectedObject];
		
		
		if((selectedObject != NULL) && [selectedObject isKindOfClass:[Node class]]) {
			Node *firstNode = (Node *) selectedObject;
			
			int secondNodeIndex = [objectMap nodesCount] - 1;
			Node *secondNode = [objectMap nodeAtIndex:secondNodeIndex];
			
			Bond *bond = [[Bond alloc] initWithNodeA:firstNode nodeB:secondNode];
			[objectMap addBond:bond];
			[bond release];
			
		}

		if([selectedObject isKindOfClass:[Node class]]) {
			[toolBar setItems:nodeButtons];
		}
		else {
			Bond *bond = (Bond *) selectedObject;
			
			NSLog(@"GOT SELECTED BOND");
			
			if([bond isDouble]) {
				NSLog(@"BOND IS DOUBLE");
				[toolBar setItems:singleBondButtons];
			}
			else {
				NSLog(@"BOND IS SINGLE");
				[toolBar setItems:doubleBondButtons];
			}			
			
		}
		
		[self addSubview:toolBar];
	}
	else if([programState currentState] == ADD_NODE) {
		NSObject *selectedObject = [objectMap currentlySelectedObject];
		
		
		if((selectedObject != NULL) && [selectedObject isKindOfClass:[Node class]]) {
						
			Node *firstNode = (Node *) selectedObject;
			
			Node *secondNode = [[Node alloc] initWithXCoord:pos.x yCoord:pos.y];	
			[objectMap addNode:secondNode];		
			
			
			Bond *bond = [[Bond alloc] initWithNodeA:firstNode nodeB:secondNode];
			[objectMap addBond:bond];

			[bond release];
			[secondNode release]; //release temp node object
			
		}
		
		[objectMap clearSelectedNodes];
		[programState setCurrentState:SELECT_OBJECT];
		
	}
	else if([programState currentState] == GESTURE_MODE) {
		PointObject *pointObject = [PointObject alloc];
		[pointObject initWithPoint:pos];
		[gesturePoints addObject:pointObject];
		[pointObject release];
		NSLog(@"GESTURE POINT ADDED");
	}


	
	[self setNeedsDisplay]; // redraw entire screen
	
	return;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint	pos = [touch locationInView:self];
	
	if([programState currentState] == GESTURE_MODE) {
		PointObject *pointObject = [PointObject alloc];
		[pointObject initWithPoint:pos];
		[gesturePoints addObject:pointObject];
		[pointObject release];
		NSLog(@"GESTURE POINT ADDED");
	}
	
	[self setNeedsDisplay]; // redraw entire screen
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if([programState currentState] == GESTURE_MODE) {
		[NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
	}
	
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

- (void) setupToolbar {
	// init toolbar buttons arrays
	if([singleBondButtons count] == 0) {
		
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		[tempArray addObject:singleBondButton];
		
		singleBondButtons = [[NSArray alloc] initWithArray:tempArray];
		
		[tempArray release];
		
	}
	
	if([doubleBondButtons count] == 0) {
		
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		[tempArray addObject:doubleBondButton];
		
		doubleBondButtons = [[NSArray alloc] initWithArray:tempArray];
		
		[tempArray release];
		
	}
	
	if([nodeButtons count] == 0) {
		
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		[tempArray addObject:addNodeButton];
		[tempArray addObject:changeElementButton];
		
		nodeButtons = [[NSArray alloc] initWithArray:tempArray];
		
		[tempArray release];
		
	}

}

- (void) renderPoint:(CGPoint)point withContext:(CGContextRef)ctx {	
	
	NSLog(@"RENDER POINT X: %f", point.x);
	NSLog(@"RENDER POINT Y: %f", point.y);
	
	CGContextSetRGBFillColor(ctx, 0, 255, 0, 1.0);
    CGContextFillEllipseInRect(ctx, CGRectMake(point.x, point.y, 10.0, 10.0));
	
}

// Finished drawing chemical symbol
-(void) onTimer {
	NSLog(@"TIMER FIRED");
	
	Node *selectedNode = [objectMap currentlySelectedNode];
	[selectedNode setElementType:@"Oxygen"];
	
	[objectMap clearSelectedNodes];
	
	NSLog(@"NEW ELEMENT TYPE IS: %@", [selectedNode elementType]);
	
	[programState setCurrentState:ADD_NODE];
	[self setNeedsDisplay]; // redraw entire screen 
	
}

- (void)dealloc {
	[programState release];
	[objectMap release];
    [super dealloc];
}


@end
