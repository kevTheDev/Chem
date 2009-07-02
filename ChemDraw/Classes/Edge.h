//
//  Edge.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface Edge : NSObject {
	Node *nodeA;
	Node *nodeB;
	Node *centerNode;
	
	BOOL unconfirmedHighlight;
	BOOL confirmedHighlight;
}

- (Edge *) initWithNodeA:(Node *)nodeA nodeB:(Node *)nodeB;

- (Node *) centerPointNode;

- (void) highlight;
- (BOOL) isHighlighted;

- (void) select;
- (BOOL) isSelected;


@property (nonatomic, retain) Node *nodeA;
@property (nonatomic, retain) Node *nodeB;
@property (nonatomic, retain) Node *centerNode;

@property BOOL unconfirmedHighlight;
@property BOOL confirmedHighlight;

@end
