//
//  SelectRingSizeViewController.h
//  ChemDraw
//
//  Created by Kevin Edwards on 06/08/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelectRingSizeViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField *ringSizeTextField;
}

@property (nonatomic, retain) UITextField *ringSizeTextField;

- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void) textChanged:(NSNotification *)notification;
@end
