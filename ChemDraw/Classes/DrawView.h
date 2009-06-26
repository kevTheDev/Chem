//
//  DrawView.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Node.h"
#import "Edge.h"

@interface DrawView : UIView {	
	NSMutableArray *nodes;
	NSMutableArray *edges;
	NSMutableArray *unconfirmedHighlightedNodes;
	NSMutableArray *unconfirmedHighlightedEdges;
}

- (void) drawNode:(Node *)node;
- (void) renderNodes;

- (void) drawEdge:(Edge *)edge;
- (void) renderEdges;

- (Node *) detectNodesForPoint:(CGPoint)point;
- (void) detectClosestEdgesToPoint:(CGPoint)point withClosestNode:(Node *)closestNode;

@property (nonatomic, retain) NSMutableArray *nodes;
@property (nonatomic, retain) NSMutableArray *edges;
@property (nonatomic, retain) NSMutableArray *unconfirmedHighlightedNodes;
@property (nonatomic, retain) NSMutableArray *unconfirmedHighlightedEdges;

@end
