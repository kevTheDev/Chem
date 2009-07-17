//
//  ChemDrawAppDelegate.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ChemDrawAppDelegate.h"
#import "ChemDrawViewController.h"
#import "DrawView.h"

#import "GestureViewController.h"
#import "GestureView.h"

@implementation ChemDrawAppDelegate

@synthesize window;
@synthesize drawViewController;
@synthesize gestureViewController;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

	drawViewController = [[ChemDrawViewController alloc] initWithNibName:@"ChemDrawViewController" bundle:nil];
	navigationController = [[UINavigationController alloc] initWithRootViewController:drawViewController];
	[self setupToolBar];
	
	[toolBar setItems:[drawViewController toolbarItems]];	
	[window addSubview:[navigationController view]];
	
	
	[window makeKeyAndVisible];
	
	NSLog(@"END OF APP LAUNCH");
	
}

- (IBAction)changeElement:(id)sender {
	NSLog(@"CHANGE ELEMENT CLICKED");	
}



- (void)dealloc {
	
	[navigationController release];
	[gestureViewController release];
    [drawViewController release];
    [window release];
    [super dealloc];
}

- (void) setupToolBar {
	//Initialize the toolbar
	toolBar = [[UIToolbar alloc] init];
	toolBar.barStyle = UIBarStyleDefault;

	//Set the toolbar to fit the width of the app.
	[toolBar sizeToFit];

	//Caclulate the height of the toolbar
	CGFloat toolBarHeight = [toolBar frame].size.height;

	//Get the bounds of the parent view
	//CGRect rootViewBounds = self.parentViewController.view.bounds;
	CGRect rootViewBounds = [[navigationController view] bounds];

	//Get the height of the parent view.
	CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);

	//Get the width of the parent view,
	CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);

	//Create a rectangle for the toolbar
	CGRect rectArea = CGRectMake(0, rootViewHeight - toolBarHeight, rootViewWidth, toolBarHeight);

	//Reposition and resize the receiver
	[toolBar setFrame:rectArea];

	//Add the toolbar as a subview to the navigation controller.
	[self.navigationController.view addSubview:toolBar];

}


@end
