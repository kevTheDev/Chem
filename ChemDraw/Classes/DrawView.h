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
}

- (void) drawNode:(Node *)node;
- (void) renderNodes;

- (void) drawEdge:(Edge *)edge;
- (void) renderEdges;

- (void) renderText:(char *)text withXCoord:(CGFloat)xCoord withYCoord:(CGFloat)yCoord withContext:(CGContextRef)ctx;


- (void) drawNodePoint:(CGPoint)nodePoint;



@end
