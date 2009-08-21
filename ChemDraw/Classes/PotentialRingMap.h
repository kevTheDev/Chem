//
//  PotentialRingMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 21/08/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Bond;
@class Node;

@interface PotentialRingMap : NSObject {
	NSInteger ringSize;
	Bond *baseBond;
	
	Node *nodeA;
	Node *nodeB;
	
	Bond *tempBondA;
	Bond *tempBondB;
	Bond *tempBondC;
	Bond *tempBondD;
}
- (PotentialRingMap *) initWithRingSize:(NSInteger)ringNumber andBaseBond:(Bond *)bond;
- (void) renderWithContext:(CGContextRef)ctx;

@property (nonatomic) NSInteger ringSize;
@property (nonatomic, retain) Bond *baseBond;

@end