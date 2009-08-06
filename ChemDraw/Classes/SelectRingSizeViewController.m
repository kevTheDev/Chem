//
//  SelectRingSizeViewController.m
//  ChemDraw
//
//  Created by Kevin Edwards on 06/08/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SelectRingSizeViewController.h"


@implementation SelectRingSizeViewController

@synthesize ringSizeTextField;

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	NSLog(@"BEGUN EDIT");

}

//UITextFieldTextDidChangeNotification

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// the user has pressed a button - therefore we have our ring size and can dismiss this screen
- (void) textChanged:(NSNotification *)notification {
	NSLog(@"textChanged");
	
	NSString *ringSize = [ringSizeTextField text];
	
	NSArray *keys = [NSArray arrayWithObjects:@"ringSize", nil];
	NSArray *objects = [NSArray arrayWithObjects:ringSize, nil];
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];

	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ringSizeSetNotification" object:self userInfo:dictionary];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"popViewNotification" object:self userInfo:dictionary];

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:@"UITextFieldTextDidChangeNotification" object:nil];
	[ringSizeTextField becomeFirstResponder];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
