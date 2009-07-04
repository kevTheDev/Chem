//
//  NodeMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Node;

@interface NodeMap : NSObject {
	NSMutableArray *nodes;
}

- (BOOL) isEmpty;

- (void) addNode:(Node *)node;
- (NSUInteger) count;

- (Node *) closestNodeToPoint:(CGPoint)point;
- (NSUInteger)indexOfObject:(id)anObject;
- (id)objectAtIndex:(NSUInteger)index;

- (void) highlightNodeAtIndex:(NSUInteger)index;
- (void) highlightNode:(Node *)node;
- (NSUInteger)highlightedNodesCount;

- (void) selectNodeAtIndex:(NSUInteger)index;
- (void) selectNode:(Node *)node;
- (NSUInteger)selectedNodesCount;

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len;

- (void) renderWithContext:(CGContextRef)ctx;
- (Node *) currentlySelectedNode;
- (Node *) currentlyHighlightedNode;

- (void) clearSelectedNodes;
- (void) clearHighlightedNodes;

- (void) removeLastNode;

@end
