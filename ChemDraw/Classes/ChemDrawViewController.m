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
		drawView = [[DrawView alloc] initWithFrame:CGRectMake(0, 0, 640, 960)];
	
		UIScrollView *scrollView = (UIScrollView *) [self view];
	
		CGSize frameRect = CGSizeMake(640, 960);
		scrollView.contentSize = frameRect;
	
		scrollView.maximumZoomScale = 4.0;
		scrollView.minimumZoomScale = 0.75;
		scrollView.clipsToBounds = YES;
		scrollView.delegate = self;
		scrollView.bounces = YES;
		[scrollView addSubview:drawView];
 
		CGRect centerRect = CGRectMake(220, 280, 320, 480);
		[scrollView zoomToRect:centerRect animated:YES];
	
	
		//Create buttons
		changeElementButton = [[UIBarButtonItem alloc]
		initWithTitle:@"Change Element" style:UIBarButtonItemStyleBordered target:self action:@selector(change_element_clicked:)];
	
		cancelButton = [[UIBarButtonItem alloc]
		initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel_clicked:)];
	
		undoButton = [[UIBarButtonItem alloc]
		initWithTitle:@"Undo" style:UIBarButtonItemStyleBordered target:self action:@selector(undo_clicked:)];

		standardButtons = [[NSArray alloc] initWithObjects:undoButton, nil];
		highlightButtons = [[NSArray alloc] initWithObjects:cancelButton, nil];
		nodeButtons = [[NSArray alloc] initWithObjects:cancelButton, changeElementButton, nil];
		
		[self setToolbarItems:standardButtons animated:YES];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(objectHighlighted:) name:@"highlightObjectNotification" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionCompleted:) name:@"actionCompleted" object:nil];

	}
    return self;
}

- (void)actionCompleted:(NSNotification *)notification {
	NSLog(@"actionCompleted");
	[self setToolbarItems:standardButtons animated:YES];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"toolBarItemsChangedNotification" object:self userInfo:nil];
}

- (void)objectHighlighted:(NSNotification *)notification {
	NSLog(@"highlightObjectNotification");
	[self setToolbarItems:highlightButtons animated:YES];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"toolBarItemsChangedNotification" object:self userInfo:nil];
}


- (void) cancel_clicked:(id)sender {
	NSLog(@"cancel_clicked");
	[drawView cancel];
}

- (void) change_element_clicked:(id)sender {
	NSLog(@"change_element_clicked");
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

 - (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return drawView;
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
