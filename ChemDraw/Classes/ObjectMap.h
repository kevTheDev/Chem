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
#import "ActionMap.h"
#import "AddNodeAction.h"
#import "AddBondAction.h"
#import "SelectAction.h"
#import "HighlightAction.h"
#import "PotentialBondMap.h"
#import "PotentialBond.h"

@interface ObjectMap : NSObject {
	
	ActionMap *actionMap;
	
	NodeMap *nodeMap;
	BondMap *bondMap;
	
	PotentialBondMap *potentialBondMap;
}

- (BOOL) isEmpty;
- (NSUInteger) count;

- (void) addNode:(Node *)node;
- (void) addBond:(Bond *)bond;

- (Node *) closestNodeToPoint:(CGPoint)point;
- (Bond *) closestBondToPoint:(CGPoint)point;
- (NSObject *) closestObjectToPoint:(CGPoint)point;

// highlighting and selecting nodes

- (NSUInteger)highlightedNodesCount;


- (NSUInteger)selectedNodesCount;

// highlighting and selecting bonds

- (NSUInteger)highlightedBondsCount;

- (NSUInteger)selectedBondsCount;

- (void) highlightClosestObjectToPoint:(CGPoint)point;
- (void) selectClosestObjectToPoint:(CGPoint)point;

// array access methods
- (id)nodeAtIndex:(NSUInteger)index;
- (id)bondAtIndex:(NSUInteger)index;

- (NSUInteger)bondsCount;
- (NSUInteger)nodesCount;

- (void) renderWithContext:(CGContextRef)ctx;

- (Bond *) currentlySelectedBond;
- (Node *) currentlySelectedNode;

- (NSObject *) currentlySelectedObject;
- (NSObject *) currentlyHighlightedObject;

- (NSUInteger) indexOfNode:(Node *)node;

- (void) clearSelectedNodes;
- (void) clearSelectedBonds;
- (void) clearSelectedObjects;
- (void) clearHighlightedObjects;

- (void) undoLastAction;

- (void) renderPotentialBondMap;

- (void) highlightClosestPotentialBondToPoint:(CGPoint)point;

@property (nonatomic, retain) NodeMap *nodeMap;
@property (nonatomic, retain) BondMap *bondMap;

@end
