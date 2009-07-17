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

	
	
	navigationController = [[UINavigationController alloc] initWithRootViewController:drawViewController];	
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


@end
