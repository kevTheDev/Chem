//
//  ChemDrawViewController.m
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ChemDrawViewController.h"
#import "DrawView.h"

@implementation ChemDrawViewController

@synthesize drawView;
//@synthesize view;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"VIEW DID LOAD");
    [super viewDidLoad];
	//drawView = [drawView initWithFrame:CGRectMake(0, 0, 640, 960)];
	drawView = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, 640, 960)];
	
	UIScrollView *scrollView = (UIScrollView *) [self view];
	
	CGSize frameRect = CGSizeMake(640, 960);
	//[[self view] setContentSize:frameRect];
	scrollView.contentSize = frameRect;
	
	scrollView.maximumZoomScale = 4.0;
	scrollView.minimumZoomScale = 0.75;
	scrollView.clipsToBounds = YES;
	scrollView.delegate = self;
	scrollView.bounces = YES;
	[scrollView addSubview:drawView];
 
	//CGRect centerRect = CGRectMake(320, 480, 320, 480);
	//[scrollView zoomToRect:centerRect animated:YES];
	
	//[drawView setNeedsDisplay];
	
//	[[self view] initWithFrame:CGRectMake(0, 0, 320, 480)];
	
//	[[self view] setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[drawView touchesBegan:touches withEvent:event];
}

 - (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return drawView;
  //return drawView;
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

- (IBAction)undoLastAction:(id)sender {
//	[[self view] undoLastAction];
}

- (IBAction)changeElement:(id)sender {
//	[[self view] changeElement:sender];
	
}

- (IBAction) cancel {
//	[[self view] cancel];
}


- (void)dealloc {
    [super dealloc];
}

@end
