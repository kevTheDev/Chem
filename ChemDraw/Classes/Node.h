//
//  Node.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Arithmetic.h"
#import "PotentialBondMap.h"

@interface Node : NSObject {
	CGFloat xCoord;
	CGFloat yCoord;
	
	BOOL unconfirmedHighlight;
	BOOL confirmedHighlight;
	
	BOOL displayPotentialBondMap;
	
	NSString *elementType;
	
	PotentialBondMap *potentialBondMap;
}

- (Node *) initWithXCoord:(CGFloat)x yCoord:(CGFloat)y;

- (int) xCoordForHash;
- (int) yCoordForHash;

- (void) highlight;
- (BOOL) isHighlighted;

- (void) select;
- (BOOL) isSelected;

- (void) renderWithContext:(CGContextRef)ctx;

@property CGFloat xCoord;
@property CGFloat yCoord;

@property BOOL unconfirmedHighlight;
@property BOOL confirmedHighlight;

@property BOOL displayPotentialBondMap;

@property (nonatomic, retain) NSString *elementType;

@end
