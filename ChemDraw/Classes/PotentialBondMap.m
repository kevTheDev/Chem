//
//  PotentialBondMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PotentialBondMap.h"


@implementation PotentialBondMap

- (PotentialBondMap *)init {
	self = [super init];
	
	if(self) {
		bonds = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void) addPotentialBond:(PotentialBond *)potentialBond {
	[bonds addObject:potentialBond];
}

- (void) renderWithContext:(CGContextRef)ctx {
	
	NSLog(@"Render potential bond map");
	
	for (PotentialBond *bond in bonds) {
		[bond renderWithContext:ctx];
	}
}

- (void) highlightClosestPotentialBondToPoint:(CGPoint)point {
	PotentialBond *closestBond = [self closestBondToPoint:point];
	[closestBond highlight];
}

- (PotentialBond *)currentlyHighlightedPotentialBond {
	for(PotentialBond *bond in bonds) {
		if([bond isHighlighted]) {
			return bond;
		}
	}
	
	return NULL;
	
}

// returns the closest bond in the map to a point
- (PotentialBond *) closestBondToPoint:(CGPoint)point {
	
	CGPoint bondCenterPoint;
	
	int closestNodeIndex = 0;
	float currentShortestDistance = 0.0;
	
	for(int i=0; i<[bonds count]; i++) {		
		bondCenterPoint = [[bonds objectAtIndex:i] centerPoint];
		
		float xDistance = abs(point.x - bondCenterPoint.x);
		float yDistance = abs(point.y - bondCenterPoint.y);
		
		float newDistance = xDistance + yDistance;
		
		if(currentShortestDistance == 0) {
			currentShortestDistance = newDistance;
		}
		else {
			
			if(newDistance < currentShortestDistance) {
				currentShortestDistance = newDistance;
				closestNodeIndex = i;
			}
			
		}
		
	}
	
	
	return [bonds objectAtIndex:closestNodeIndex];
	
}

@end
