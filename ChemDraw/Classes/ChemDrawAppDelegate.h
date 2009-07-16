//
//  ChemDrawAppDelegate.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChemDrawViewController;
//@class DrawView;

@interface ChemDrawAppDelegate : NSObject <UIApplicationDelegate, UIScrollViewDelegate> {
    UIWindow *window;
    IBOutlet ChemDrawViewController *viewController;
	IBOutlet UIScrollView *scrollView;
	//DrawView *drawView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ChemDrawViewController *viewController;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
//@property (nonatomic, retain) IBOutlet DrawView *drawView;

@end

