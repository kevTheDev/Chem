//
//  ChemDrawAppDelegate.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChemDrawViewController;
@class GestureViewController;

@interface ChemDrawAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	IBOutlet UINavigationController *navigationController;
    IBOutlet ChemDrawViewController *drawViewController;
	IBOutlet GestureViewController *gestureViewController;
	
	UIToolbar *toolBar;
}

- (void) setupToolBar;
- (void) updateToolBar:(NSNotification *)notification;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ChemDrawViewController *drawViewController;
@property (nonatomic, retain) IBOutlet GestureViewController *gestureViewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;



@end

