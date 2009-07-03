//
//  ObjectMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NodeMap.h"
#import "BondMap.h"

@interface ObjectMap : NSObject {
	NodeMap *nodeMap;
	BondMap *bondMap;
}

- (BOOL) isEmpty;
- (NSUInteger) count;

- (void) addNode:(Node *)node;
- (void) addBond:(Bond *)bond;

- (Node *) closestNodeToPoint:(CGPoint)point;
- (Bond *) closestBondToPoint:(CGPoint)point;
- (NSObject *) closestObjectToPoint:(CGPoint)point;

// highlighting and selecting nodes
- (void) highlightNode:(Node *)node;
- (NSUInteger)highlightedNodesCount;

- (void) selectNode:(Node *)node;
- (NSUInteger)selectedNodesCount;

// highlighting and selecting bonds
- (void) highlightBond:(Bond *)bond;
- (NSUInteger)highlightedBondsCount;
- (void) selectBond:(Bond *)bond;
- (NSUInteger)selectedBondsCount;

- (void) highlightClosestObjectToPoint:(CGPoint)point;
- (void) selectClosestObjectToPoint:(CGPoint)point;

// array access methods
- (id)nodeAtIndex:(NSUInteger)index;
- (id)bondAtIndex:(NSUInteger)index;

- (NSUInteger)bondsCount;

- (void) renderWithContext:(CGContextRef)ctx;

- (Bond *) currentlySelectedBond;
- (Node *) currentlySelectedNode;
- (NSObject *) currentlySelectedObject;

@property (nonatomic, retain) NodeMap *nodeMap;
@property (nonatomic, retain) BondMap *bondMap;

@end
