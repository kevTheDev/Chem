//
//  BondMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 30/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BondMap.h"
#import "NodeMap.h"

@implementation BondMap

- (BondMap *) init {
	
	self = [super init];
	
    if ( self ) {
        bonds = [[NSMutableArray alloc] initWithCapacity:5];
    }
	
    return self;
	
}

- (NSUInteger)selectedBondsCount {
	int count = 0;
	
	for(Bond *bond in bonds) {
		if([bond isSelected]) {
			count++;
		}
	}
	
	return count;
}

- (void) selectBond:(Bond *)bond {
	NSUInteger bondIndex = [bonds indexOfObject:bond];
	[self selectBondAtIndex:bondIndex];
}

- (void) selectBondAtIndex:(NSUInteger)index {
	Bond *bond = [bonds objectAtIndex:index];
	[bond select];
	return;
}

- (NSUInteger)highlightedBondsCount {
	int count = 0;
	
	for(Bond *bond in bonds) {
		if([bond isHighlighted]) {
			count++;
		}
	}
	
	return count;
}

- (NSUInteger)indexOfObject:(id)anObject {
	return [bonds indexOfObject:anObject];
}

- (id)objectAtIndex:(NSUInteger)index {
	return [bonds objectAtIndex:index];
}

- (void) highlightBondAtIndex:(NSUInteger)index {
	Bond *bond = [bonds objectAtIndex:index];
	[bond highlight];
	return;
}

- (void) highlightBond:(Bond *)bond {
	NSUInteger bondIndex = [bonds indexOfObject:bond];
	NSLog(@"EDGE MAP INDEX: %d", bondIndex);
	[self highlightBondAtIndex:bondIndex];
}

- (NSUInteger) count {
	return [bonds count];
}

- (BOOL) isEmpty {
	return [bonds count] == 0;	
}

- (void) addBond:(Bond *)bond {
	[bonds addObject:bond];
}

// returns the closest bond in the map to a point
- (Bond *) closestBondToPoint:(CGPoint)point {

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

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
	return [bonds countByEnumeratingWithState:state objects:stackbuf count:len];
}

- (void) renderWithContext:(CGContextRef)ctx {
	for (Bond *bond in bonds) {
		[bond renderWithContext:ctx];
	}
}

- (Bond *) currentlySelectedBond {
	for(Bond *bond in bonds) {
		if([bond isSelected]) {
			return bond;
		}
	}
	
	return NULL;
}

- (Bond *) currentlyHighlightedBond {
	for(Bond *bond in bonds) {
		if([bond isHighlighted]) {
			return bond;
		}
	}
	
	return NULL;
}

- (void) clearSelectedBonds {
	for(Bond *bond in bonds) {
		[bond setConfirmedHighlight:NO];
	}
}

- (void) clearHighlightedBonds {
	for(Bond *bond in bonds) {
		[bond setUnconfirmedHighlight:NO];
	}
}

- (void)dealloc {
	[bonds release];
    [super dealloc];
}

@end
