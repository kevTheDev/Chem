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
@class CharacterMatch;

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
	
	int testInt;
	
}

-(void) actionCompleted;

- (void) renderText:(char *)text withXCoord:(CGFloat)xCoord withYCoord:(CGFloat)yCoord withContext:(CGContextRef)ctx;

- (IBAction)changeElement:(id)sender;

- (IBAction)undoLastAction:(id)sender;

- (IBAction) cancel;


- (void) renderPoint:(CGPoint)point withContext:(CGContextRef)ctx;
- (void) highlightTouchedObject:(CGPoint)pos;
- (void) selectTouchedObject:(CGPoint)pos;
- (void) updateSelectedElementWithCharacterMatch:(CharacterMatch *)topMatch;

- (void) drawPotentialRings:(NSInteger)ringSize;

@property (nonatomic, retain) NSTimer *symbolTimer;
@property (nonatomic, retain) NSArray *toolBarItems;
@property (nonatomic, retain) ProgramState *programState;
@property (nonatomic) int testInt;

@end


