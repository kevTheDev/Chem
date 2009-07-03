//
//  PotentialBond.h
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PotentialBond : NSObject {

	CGPoint startPoint;
	CGPoint endPoint;
	
}

- (PotentialBond *)initWithStartPoint:(CGPoint)pointOne endPoint:(CGPoint)pointTwo;

- (void) renderWithContext:(CGContextRef)ctx;

@end
