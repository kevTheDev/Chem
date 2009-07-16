//
//  Bond.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <ApplicationServices/ApplicationServices.h>

# define SINGLE_BOND 1
# define DOUBLE_BOND 2
# define TRIPLE_BOND 3


@class Node;

@interface Bond : NSObject {
	Node *nodeA;
	Node *nodeB;
	CGPoint centerPoint;
	CGPoint nodeAPoint;
	CGPoint nodeBPoint;
	
	BOOL unconfirmedHighlight;
	BOOL confirmedHighlight;
	
	int numberOfParts;
}

- (Bond *) initWithNodeA:(Node *)nodeA nodeB:(Node *)nodeB;

- (Node *) centerPointNode;

- (void) highlight;
- (BOOL) isHighlighted;

- (void) select;
- (BOOL) isSelected;


- (void) renderWithContext:(CGContextRef)ctx;

- (BOOL) hasNodeToNorthOfNode:(Node *)node;
- (BOOL) hasNodeToSouthOfNode:(Node *)node;
- (BOOL) hasNodeToEastOfNode:(Node *)node;
- (BOOL) hasNodeToWestOfNode:(Node *)node;

- (BOOL) hasNodeToNorthEastOfNode:(Node *)node;
- (BOOL) hasNodeToNorthWestOfNode:(Node *)node;
- (BOOL) hasNodeToSouthEastOfNode:(Node *)node;
- (BOOL) hasNodeToSouthWestOfNode:(Node *)node;

- (BOOL) isSingle;
- (BOOL) isDouble;
- (BOOL) isTriple;

- (void) makeSingle;
- (void) makeDouble;
- (void) makeTriple;

@property (nonatomic, retain) Node *nodeA;
@property (nonatomic, retain) Node *nodeB;
@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) CGPoint nodeAPoint;
@property (nonatomic) CGPoint nodeBPoint;

@property (nonatomic) BOOL unconfirmedHighlight;
@property (nonatomic) BOOL confirmedHighlight;

@end
