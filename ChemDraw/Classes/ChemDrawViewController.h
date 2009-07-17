//
//  ChemDrawViewController.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrawView;

@interface ChemDrawViewController : UIViewController {
	IBOutlet UIToolbar *toolBar;
	IBOutlet UIBarButtonItem *changeElementButton;
	
	IBOutlet UIBarButtonItem *undoButton;
	IBOutlet UIBarButtonItem *cancelButton;
	
//	IBOutlet UIScrollView *scrollView;
	IBOutlet DrawView *view;
}

//- (IBAction)changeElement:(id)sender;

//- (IBAction)undoLastAction:(id)sender;

//- (IBAction) cancel;

//@property (nonatomic, retain) IBOutlet DrawView *drawView;
//@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@end

