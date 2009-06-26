//
//  ChemDrawAppDelegate.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChemDrawViewController;

@interface ChemDrawAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ChemDrawViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ChemDrawViewController *viewController;

@end

