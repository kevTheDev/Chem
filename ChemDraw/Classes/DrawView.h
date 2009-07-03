//
//  DrawView.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProgramState.h"
#import "Node.h"
#import "Bond.h"
#import "ObjectMap.h"

@interface DrawView : UIView {	
	
	ProgramState *programState;
	ObjectMap *objectMap;
	
	NSArray *singleBondButtons;
	NSArray *doubleBondButtons;
	NSArray *nodeButtons;
	
	IBOutlet UIToolbar *toolBar;
	
	IBOutlet UIBarButtonItem *singleBondButton;
	IBOutlet UIBarButtonItem *doubleBondButton;
	
	IBOutlet UIBarButtonItem *addNodeButton;
	IBOutlet UIBarButtonItem *changeElementButton;
	
}

- (void) renderText:(char *)text withXCoord:(CGFloat)xCoord withYCoord:(CGFloat)yCoord withContext:(CGContextRef)ctx;

- (IBAction)makeDoubleBond:(id)sender;
- (IBAction)makeSingleBond:(id)sender;

- (IBAction)addNewNode:(id)sender;
- (IBAction)changeElement:(id)sender;

- (void) setupToolbar;

@end
