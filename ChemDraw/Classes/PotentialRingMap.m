//
//  PotentialRingMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 21/08/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PotentialRingMap.h"
#import "Bond.h"
#import "Node.h"

@implementation PotentialRingMap

@synthesize ringSize;
@synthesize baseBond;

- (PotentialRingMap *) initWithRingSize:(NSInteger)ringNumber andBaseBond:(Bond *)bond {
	
	self = [super init];
	
    if ( self ) {
        ringSize = ringNumber;
		baseBond = bond;
		
		if([[self baseBond] isHorizontal]) {
	
			NSLog(@"HORIZONTAL BASE BOND");
			Node *centerNode = [baseBond centerPointNode];
			
			CGPoint newPoint = CGPointMake(centerNode.xCoord, centerNode.yCoord);
			nodeA = [[Node alloc] initWithXCoord:newPoint.x yCoord:newPoint.y + 100];
			
			nodeB = [[Node alloc] initWithXCoord:newPoint.x yCoord:newPoint.y - 100];
		
	
		}
		else if([[self baseBond] isVertical]) {
	
			NSLog(@"VERTICAL BASE BOND");
	
		}
		else {
			NSLog(@"NOT VERTICAL OR HORIZONTAL");
		}
    }	
    return self;	
}

- (void) dealloc {
	[super dealloc];
}

- (void) renderWithContext:(CGContextRef)ctx {

	NSLog(@"POTENTIAL MAP RENDER CALLED");
	[nodeA renderWithContext:ctx];
	[nodeB renderWithContext:ctx];
	 
	
}

@end
