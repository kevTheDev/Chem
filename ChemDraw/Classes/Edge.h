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
	
	BOOL unconfirmedHighlight;
}

- (Edge *) initWithNodeA:(Node *)nodeA nodeB:(Node *)nodeB;

- (Node *) centerPointNode;

@property (nonatomic, retain) Node *nodeA;
@property (nonatomic, retain) Node *nodeB;

@property BOOL unconfirmedHighlight;

@end
