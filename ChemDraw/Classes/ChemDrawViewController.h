//
//  ChemDrawViewController.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrawView;

@interface ChemDrawViewController : UIViewController <UIScrollViewDelegate> {
	IBOutlet UIToolbar *toolBar;
	IBOutlet UIBarButtonItem *changeElementButton;
	
	IBOutlet UIBarButtonItem *undoButton;
	IBOutlet UIBarButtonItem *cancelButton;
	
	IBOutlet DrawView *drawView;
	
	NSArray *standardButtons;
	NSArray *highlightButtons;
	NSArray *nodeButtons;
}

- (void) cancel_clicked;
- (void) change_element_clicked;
- (void) undo_clicked:(id)sender;

@property (nonatomic, retain) IBOutlet DrawView *drawView;

@end

