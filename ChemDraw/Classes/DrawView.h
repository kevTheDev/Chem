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
#import "ObjectMap.h"

@interface DrawView : UIView {	
	ObjectMap *objectMap;
	
//	NSMutableArray *nodes;
//	NSMutableArray *edges;
//	NSMutableArray *unconfirmedHighlightedNodes;
//	NSMutableArray *unconfirmedHighlightedEdges;
}

- (void) drawNode:(Node *)node;
- (void) renderNodes;

- (void) drawEdge:(Edge *)edge;
- (void) renderEdges;

//- (void) renderPlainNodes;
//- (void) renderSelectedNodes;
//- (void) renderHighlightedNodes;
//
//- (void) renderPlainEdges;
//- (void) renderHighlightedEdges;
//- (void) renderSelectedEdges;

- (void) drawNodePoint:(CGPoint)nodePoint;

//- (Node *) detectNodesForPoint:(CGPoint)point;
//- (void) detectClosestEdgesToPoint:(CGPoint)point withClosestNode:(Node *)closestNode;
//
//- (Node *) confirmNodeFromHighlightedNodes:(CGPoint)point;
//- (Edge *) confirmEdgeFromHighlightedEdges:(CGPoint)point;

//@property (nonatomic, retain) NSMutableArray *nodes;
//@property (nonatomic, retain) NSMutableArray *edges;
//@property (nonatomic, retain) NSMutableArray *unconfirmedHighlightedNodes;
//@property (nonatomic, retain) NSMutableArray *unconfirmedHighlightedEdges;

@end
