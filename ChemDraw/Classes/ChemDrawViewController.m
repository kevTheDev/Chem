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

- (void)dealloc {
    [super dealloc];
}


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		// ALL THIS STUFF SHOULD BE IN THE INIT METHOD
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
 
		CGRect centerRect = CGRectMake(220, 280, 320, 480);
		[scrollView zoomToRect:centerRect animated:YES];
	
	
		//Create a button
		changeElementButton = [[UIBarButtonItem alloc]
		initWithTitle:@"Change Element" style:UIBarButtonItemStyleBordered target:self action:@selector(change_element_clicked:)];
	
		cancelButton = [[UIBarButtonItem alloc]
		initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel_clicked:)];
	
		undoButton = [[UIBarButtonItem alloc]
		initWithTitle:@"Undo" style:UIBarButtonItemStyleBordered target:self action:@selector(undo_clicked:)];

		standardButtons = [[NSArray alloc] initWithObjects:undoButton, nil];
		[self setToolbarItems:standardButtons animated:YES];

	}
    return self;
}

- (void) undo_clicked:(id)sender {
	NSLog(@"undo_clicked");
	[drawView undoLastAction:sender];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"VIEW DID LOAD");
    [super viewDidLoad];
	
		
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




@end
