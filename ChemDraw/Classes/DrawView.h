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
	
	NSArray *highlightButtons;
	NSArray *nodeButtons;
	NSArray *standardButtons;
	
	IBOutlet UIToolbar *toolBar;
	IBOutlet UIBarButtonItem *changeElementButton;
	
	IBOutlet UIBarButtonItem *undoButton;
	IBOutlet UIBarButtonItem *cancelButton;
	
	PointObjectMap *gesturePoints;
	
	NSTimer *symbolTimer;
	NSArray *toolBarItems;
}

-(void) actionCompleted;

- (void) renderText:(char *)text withXCoord:(CGFloat)xCoord withYCoord:(CGFloat)yCoord withContext:(CGContextRef)ctx;

- (IBAction)changeElement:(id)sender;

- (IBAction)undoLastAction:(id)sender;

- (IBAction) cancel;

- (void) setupToolbarButtonArrays;

- (void) renderPoint:(CGPoint)point withContext:(CGContextRef)ctx;

-(void) onTimer;

@property (nonatomic, retain) NSTimer *symbolTimer;
@property (nonatomic, retain) NSArray *toolBarItems;


@end


