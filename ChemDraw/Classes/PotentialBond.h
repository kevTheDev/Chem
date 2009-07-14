//
//  PotentialBond.h
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <ApplicationServices/ApplicationServices.h>

@interface PotentialBond : NSObject {

	CGPoint startPoint;
	CGPoint endPoint;
	CGPoint centerPoint;
	
	BOOL highlighted;
	BOOL selected;
}

- (PotentialBond *)initWithStartPoint:(CGPoint)pointOne endPoint:(CGPoint)pointTwo;

- (void) renderWithContext:(CGContextRef)ctx;

- (void) setupCenterPoint;

- (void) highlight;
- (BOOL) isHighlighted;

- (void) select;
- (BOOL) isSelected;

@property CGPoint endPoint;
@property CGPoint centerPoint;

@end
