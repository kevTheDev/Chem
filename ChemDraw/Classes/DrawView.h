//
//  DrawView.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGLDrawable.h>

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@class ProgramState;
@class Node;
@class Bond;
@class ObjectMap;
@class PointObject;
@class PointObjectMap;

@interface DrawView : UIView {	
	
	ProgramState *programState;
	ObjectMap *objectMap;
	
	NSArray *singleBondButtons;
	NSArray *doubleBondButtons;
	NSArray *nodeButtons;
	NSArray *standardButtons;
	
	IBOutlet UIToolbar *toolBar;
	
	IBOutlet UIBarButtonItem *singleBondButton;
	IBOutlet UIBarButtonItem *doubleBondButton;
	
	IBOutlet UIBarButtonItem *addNodeButton;
	IBOutlet UIBarButtonItem *changeElementButton;
	
	IBOutlet UIBarButtonItem *undoButton;
	
	PointObjectMap *gesturePoints;
	
	NSTimer *symbolTimer;
	
}

- (void) renderText:(char *)text withXCoord:(CGFloat)xCoord withYCoord:(CGFloat)yCoord withContext:(CGContextRef)ctx;

- (IBAction)makeDoubleBond:(id)sender;
- (IBAction)makeSingleBond:(id)sender;

- (IBAction)addNewNode:(id)sender;
- (IBAction)changeElement:(id)sender;

- (IBAction)undoLastAction:(id)sender;

- (void) setupToolbarButtonArrays;

- (void) renderPoint:(CGPoint)point withContext:(CGContextRef)ctx;

-(void) onTimer;



@end
