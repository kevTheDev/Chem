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

@implementation ChemDrawAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize scrollView;
//@synthesize drawView;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	//CGRect frame = CGRectMake(0, 0, 640, 960);
	//NSLog(@"CREATE RECT");
	//drawView = [[DrawView alloc] initWithFrame:frame];
	//NSLog(@"INIT DRAW VIEW");
	
    // Override point for customization after app launch    
    //[window addSubview:viewController.view];
    
	
	//scrollView.contentSize = CGSizeMake([[[viewController view] frame] width], 960);
	CGRect frameRect = viewController.view.frame;
	scrollView.contentSize = frameRect.size;
	scrollView.maximumZoomScale = 4.0;
	scrollView.minimumZoomScale = 0.75;
	scrollView.clipsToBounds = YES;
	scrollView.delegate = self;
	//[scrollView addSubview:drawView];
	[scrollView addSubview:viewController.view];
	
	[window makeKeyAndVisible];
	
	NSLog(@"END OF APP LAUNCH");
	
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return viewController.view;
	//return drawView;
}

- (void)dealloc {
	//[drawView release];
	[scrollView release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
