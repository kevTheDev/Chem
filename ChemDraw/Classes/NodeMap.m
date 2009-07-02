//
//  NodeMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 02/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NodeMap.h"


@implementation NodeMap

///@synthesize nodes;
//@synthesize highlightedNodes;
//@synthesize selectedNodes;

- (NodeMap *) init {
	
	self = [super init];
	
    if ( self ) {
        nodes = [[NSMutableArray alloc] initWithCapacity:5];
		//highlightedNodes = [[NSMutableArray alloc] initWithCapacity:5];
		//selectedNodes = [[NSMutableArray alloc] initWithCapacity:5];
    }
	
    return self;
	
}

- (void) selectNodeAtIndex:(NSUInteger)index {
	Node *node = [nodes objectAtIndex:index];
	
	[node select];
	
	//[selectedNodes addObject:node];
	//[highlightedNodes removeObject:node];
	return;
}

- (void) selectNode:(Node *)node {
	NSUInteger nodeIndex = [nodes indexOfObject:node];
	[self selectNodeAtIndex:nodeIndex];
}

- (NSUInteger)selectedNodesCount {
	int count = 0;
	
	for(Node *node in nodes) {
		if([node isSelected]) {
			count++;
		}
	}
	return count;
}

- (NSUInteger)highlightedNodesCount {
	int count = 0;
	
	for(Node *node in nodes) {
		if([node isHighlighted]) {
			count++;
		}
	}
		
	return count;
}

- (void) highlightNodeAtIndex:(NSUInteger)index {
	Node *node = [nodes objectAtIndex:index];

	[node highlight];
	//[highlightedNodes addObject:node];
	//[nodes removeObject:node];
	
}

- (void) highlightNode:(Node *)node {
	NSUInteger nodeIndex = [nodes indexOfObject:node];
	NSLog(@"NODE MAP INDEX: %d", nodeIndex);
	[self highlightNodeAtIndex:nodeIndex];
}

- (NSUInteger)indexOfObject:(id)anObject {
	return [nodes indexOfObject:anObject];
}

- (id)objectAtIndex:(NSUInteger)index {
	return [nodes objectAtIndex:index];
	
}

- (BOOL) isEmpty {
	return [nodes count] == 0;	
}

- (NSUInteger) count {
	return [nodes count];
}

- (void) addNode:(Node *)node {
	[nodes addObject:node];
}

// returns the closest node in the map to a point
- (Node *) closestNodeToPoint:(CGPoint)point {
	
	Node *tempNode;
	
	int closestNodeIndex = 0;
	float currentShortestDistance = 0;
	
	for(int i=0; i<[nodes count]; i++)
	{
		tempNode = [nodes objectAtIndex:i];
		
		float xDistance = abs(point.x - [tempNode xCoord]);
		float yDistance = abs(point.y - [tempNode yCoord]);
		
		float newDistance = xDistance + yDistance;
		
		if(currentShortestDistance == 0) {
			currentShortestDistance = newDistance;
		}
		else {
			
			if(newDistance < currentShortestDistance) {
				currentShortestDistance = newDistance;
				closestNodeIndex = i;
			}
			
		}
	} // end of for loop
	
	return [nodes objectAtIndex:closestNodeIndex];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
	return [nodes countByEnumeratingWithState:state objects:stackbuf count:len];
}

- (void) dealloc {
	//[highlightedNodes release];
	[nodes release];
	[super dealloc];	
}

@end
