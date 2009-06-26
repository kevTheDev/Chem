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
}

- (void) drawNode:(Node *)node;
- (void) renderNodes;

- (void) drawEdge:(Edge *)edge;
- (void) renderEdges;

- (void) detectNodesForPoint:(CGPoint)point;

@property (nonatomic, retain) NSMutableArray *nodes;
@property (nonatomic, retain) NSMutableArray *edges;


@end
