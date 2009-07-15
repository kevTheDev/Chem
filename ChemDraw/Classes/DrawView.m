//
//  DrawView.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DrawView.h"
#import "ProgramState.h"
#import "Node.h"
#import "Bond.h"
#import "ObjectMap.h"
#import "PointObject.h"
#import "PotentialBond.h"
#import "PointObjectMap.h"
#import "CharacterMatch.h"

#import <QuartzCore/QuartzCore.h>


@implementation DrawView

@synthesize symbolTimer;

// this init method never seems to really get called
- (id)initWithFrame:(CGRect)frame {
		
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		
    }
	
		
    return self;
}

- (IBAction)undoLastAction:(id)sender {
	[objectMap undoLastAction];
	[programState setCurrentState:SELECT_OBJECT];
	[toolBar setItems:standardButtons];
	NSLog(@"UNDO LAST ACTION");
	
	[self setNeedsDisplay]; // redraw entire screen
}

- (IBAction)changeElement:(id)sender {
	NSLog(@"Change element");
	[programState setCurrentState:GESTURE_MODE];
	[toolBar setItems:standardButtons];
	[self setNeedsDisplay]; // redraw entire screen
	
}

- (IBAction)makeDoubleBond:(id)sender {
	
	Bond *selectedBond = [objectMap currentlySelectedBond];

	[selectedBond setIsDouble:YES];
	
	//[toolBar removeFromSuperview];	
	[objectMap clearSelectedBonds];
	
	[programState setCurrentState:SELECT_OBJECT];
	
	[toolBar setItems:standardButtons];
	[self setNeedsDisplay]; // redraw entire screen
	
	
	
}

- (IBAction)makeSingleBond:(id)sender {
	
	Bond *selectedBond = [objectMap currentlySelectedBond];
	
	[selectedBond setIsDouble:NO];
	
	//[toolBar removeFromSuperview];	
	[objectMap clearSelectedBonds];
	
	[programState setCurrentState:SELECT_OBJECT];
	[toolBar setItems:standardButtons];
	[self setNeedsDisplay]; // redraw entire screen
	
	
	
}

// find the selected node, and present the potentialBondMap
- (IBAction)addNewNode:(id)sender {
	
	[objectMap renderPotentialBondMap];
	[programState setCurrentState:HIGHLIGHT_POTENTIAL_BOND];
	[toolBar setItems:standardButtons];
	[self setNeedsDisplay]; // redraw entire screen
}


- (void)drawRect:(CGRect)rect {


	
	if(programState == NULL) {
		programState = [[ProgramState alloc] init];
		objectMap = [[ObjectMap alloc] init];
		[self setupToolbarButtonArrays];
		gesturePoints = [[PointObjectMap alloc] init];
	}

	// got the graphics context
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	if([programState currentState] == GESTURE_MODE) {
		[[UIColor whiteColor] setFill]; 
		UIRectFill(rect);
		
		[gesturePoints renderWithContext:ctx];

	}
	else if([programState currentState] == DEBUG_MODE) {
		[[UIColor whiteColor] setFill]; 
		UIRectFill(rect);

		[gesturePoints renderCompressedPointsWithContext:ctx];
		
	}
	else {
		// Drawing code
		[[UIColor whiteColor] setFill]; 
		UIRectFill(rect);
		
		
		
		
		[objectMap renderWithContext:ctx];
	}
   
	char *prompt = [programState currentPrompt];
	[self renderText:prompt withXCoord:15.0 withYCoord:50.0 withContext:(CGContextRef)ctx];
	
	if([programState currentState] == DEBUG_MODE) {
	}

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint	pos = [touch locationInView:self];
	
	switch([programState currentState]) {
		case SELECT_OBJECT:
			NSLog(@"TOUCH BEGAN, SCREEN STATE: SELECT_OBJECT");
			break;
		case MANIPULATE_OBJECT:
			NSLog(@"TOUCH BEGAN, SCREEN STATE: MANIPULATE_OBJECT");
			break;
		case HIGHLIGHT_POTENTIAL_BOND:
			NSLog(@"TOUCH BEGAN, SCREEN STATE: HIGHLIGHT_POTENTIAL_BOND");
			break;
		case GESTURE_MODE:
			NSLog(@"TOUCH BEGAN, SCREEN STATE: GESTURE_MODE");
			break;
		default:
			NSLog(@"TOUCH BEGAN, SCREEN STATE: NO STATE");
			break;
	}

	if([programState currentState] == SELECT_OBJECT) {

		[objectMap highlightClosestObjectToPoint:pos];
		[programState setCurrentState:MANIPULATE_OBJECT];
			
	}
	else if([programState currentState] == MANIPULATE_OBJECT) {
		
		// detect a user confirming a highlighted object
		[objectMap selectClosestObjectToPoint:pos];
		
		NSObject *selectedObject = [objectMap currentlySelectedObject];
		
		// if we have selected a node then show the node buttons
		if((selectedObject != NULL) && [selectedObject isKindOfClass:[Node class]]) {
			
			// special case - if we highlight one node and click on another - create a bond to join them
			
			NSObject *highlightedObject = [objectMap currentlyHighlightedObject];
			if([highlightedObject isKindOfClass:[Node class]] && ![highlightedObject isEqual:selectedObject]) {
				NSLog(@"JOIN TWO NODES TOGETHER");
				Bond *bond = [[Bond alloc] initWithNodeA:(Node *)selectedObject nodeB:(Node *)highlightedObject];
				[objectMap addBond:bond];
				
				[programState setCurrentState:SELECT_OBJECT];
				[objectMap clearSelectedObjects];
				[objectMap clearHighlightedObjects];
				
			}
			else {
				[toolBar setItems:nodeButtons animated:YES];
				
				[programState setCurrentState:TOOLBAR_MODE];
			}
		}
		else {
			Bond *bond = (Bond *) selectedObject;
			
			NSLog(@"GOT SELECTED BOND");
			
			if([bond isDouble]) {
				NSLog(@"BOND IS DOUBLE");
				[toolBar setItems:singleBondButtons animated:YES];
			}
			else {
				NSLog(@"BOND IS SINGLE");
				[toolBar setItems:doubleBondButtons animated:YES];
			}
			[programState setCurrentState:TOOLBAR_MODE];
			
		}
		
		
	}
	else if([programState currentState] == HIGHLIGHT_POTENTIAL_BOND) {
		
		// new code design means that we need to choose from the potential bond map that should currently be on display
		[objectMap highlightClosestPotentialBondToPoint:pos];
		[programState setCurrentState:SELECT_POTENTIAL_BOND];
		
	}
	else if([programState currentState] == SELECT_POTENTIAL_BOND) {
		
		// here we confirm the potential bond
		// this means that we have to make it into a real bond with real nodes
		Node *currentlySelectedNode = (Node *) [objectMap currentlySelectedObject]; //the first node in the bond
		
		PotentialBond *selectedPotentialBond = [objectMap currentlyHighlightedPotentialBond];
		CGPoint nodeEndPoint = [selectedPotentialBond endPoint];
		
		Node *secondNode = [[Node alloc] initWithXCoord:nodeEndPoint.x yCoord:nodeEndPoint.y];
		[objectMap addNode:secondNode];
		
		Bond *bond = [[Bond alloc] initWithNodeA:currentlySelectedNode nodeB:secondNode];
		[objectMap addBond:bond];
		
		[objectMap clearSelectedNodes];
		
		[programState setCurrentState:SELECT_OBJECT];
		
	}
	else if([programState currentState] == GESTURE_MODE) {
		PointObject *pointObject = [PointObject alloc];
		[pointObject initWithPoint:pos];
		[gesturePoints addPoint:pointObject];
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
		[gesturePoints addPoint:pointObject];
		
		[self setNeedsDisplay];
	}
	
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if([programState currentState] == GESTURE_MODE) {
		NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.80 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
		[self setSymbolTimer:timer];
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



- (void) setupToolbarButtonArrays {
	// init toolbar buttons arrays
	if([singleBondButtons count] == 0) {
		
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		[tempArray addObject:singleBondButton];
		[tempArray addObject:undoButton];
		
		singleBondButtons = [[NSArray alloc] initWithArray:tempArray];
		
		[tempArray release];
		
	}
	
	if([doubleBondButtons count] == 0) {
		
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		[tempArray addObject:doubleBondButton];
		[tempArray addObject:undoButton];
		
		doubleBondButtons = [[NSArray alloc] initWithArray:tempArray];
		
		[tempArray release];
		
	}
	
	if([nodeButtons count] == 0) {
		
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		[tempArray addObject:addNodeButton];
		[tempArray addObject:changeElementButton];
		[tempArray addObject:undoButton];
		
		nodeButtons = [[NSArray alloc] initWithArray:tempArray];
		
		[tempArray release];
		
	}
	
	if([standardButtons count] == 0) {
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		[tempArray addObject:undoButton];
		
		standardButtons = [[NSArray alloc] initWithArray:tempArray];
		
		[tempArray release];
	}
	
	[toolBar setItems:standardButtons];

}


- (void) renderPoint:(CGPoint)point withContext:(CGContextRef)ctx {	
	
	CGContextSetRGBFillColor(ctx, 0, 255, 0, 1.0);
    CGContextFillEllipseInRect(ctx, CGRectMake(point.x, point.y, 10.0, 10.0));
	
}

// Finished drawing chemical symbol
-(void) onTimer {

	CharacterMatch *topMatch = [gesturePoints compressPoints];

	Node *selectedNode = [objectMap currentlySelectedNode];
	NSString *characterSymbol = [topMatch characterSymbol];
	[selectedNode setElementType:characterSymbol];
	[objectMap clearSelectedNodes];
	NSLog(@"NEW ELEMENT TYPE IS: %@", [selectedNode elementType]);



	

//	[programState setCurrentState:DEBUG_MODE];
	[programState setCurrentState:SELECT_OBJECT];
	[symbolTimer invalidate];
	[self setSymbolTimer:NULL];
	
	[gesturePoints clearPoints];
	[self setNeedsDisplay]; // redraw entire screen
	
	
	

	
}


- (void)dealloc {
	[programState release];
	[objectMap release];
    [super dealloc];
}


@end
