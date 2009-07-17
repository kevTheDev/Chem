//
//  GestureView.h
//  ChemDraw
//
//  Created by Kevin Edwards on 17/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PointObjectMap;
@class CharacterMatch;

@interface GestureView : UIView {
	PointObjectMap *gesturePoints;
	CharacterMatch *matchedCharacter;
	NSTimer *symbolTimer;
}

@property (nonatomic, retain) CharacterMatch *matchedCharacter;
@property (nonatomic, retain) NSTimer *symbolTimer;

@end
