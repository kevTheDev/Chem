//
//  GestureViewController.m
//  ChemDraw
//
//  Created by Kevin Edwards on 17/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GestureViewController.h"
#import "GestureView.h"

@implementation GestureViewController



// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		self.view = [[GestureView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		
		
		
		
    }
    return self;
}



/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"GESTURE VIEW DID LOAD");
    [super viewDidLoad];
	
	[[self view] setNeedsDisplay];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
    [super dealloc];
}



@end
