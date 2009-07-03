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
	
	//UIBarButtonItem *doubleBondButton;
	IBOutlet UIToolbar *toolBar;
}

- (void) renderText:(char *)text withXCoord:(CGFloat)xCoord withYCoord:(CGFloat)yCoord withContext:(CGContextRef)ctx;

- (IBAction)makeDoubleBond:(id)sender;

@end
