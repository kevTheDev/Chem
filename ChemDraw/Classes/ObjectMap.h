//
//  ObjectMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NodeMap.h"
#import "EdgeMap.h"

@interface ObjectMap : NSObject {
	NodeMap *nodeMap;
	EdgeMap *edges;
}

- (BOOL) isEmpty;
- (NSUInteger) count;

- (void) addNode:(Node *)node;
- (void) addEdge:(Edge *)edge;

- (Node *) closestNodeToPoint:(CGPoint)point;
- (Edge *) closestEdgeToPoint:(CGPoint)point;
- (NSObject *) closestObjectToPoint:(CGPoint)point;

// highlighting and selecting nodes
- (void) highlightNode:(Node *)node;
- (NSUInteger)highlightedNodesCount;

- (void) selectNode:(Node *)node;
- (NSUInteger)selectedNodesCount;

@property (nonatomic, retain) NodeMap *nodeMap;

@end
