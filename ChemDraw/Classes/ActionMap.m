//
//  ActionMap.m
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ActionMap.h"

#import "Action.h"

@implementation ActionMap

- (ActionMap *) init {
	self = [super init];
	
	if(self) {
		actions = [[NSMutableArray alloc] init];
	}
	
	return self;
	
}

- (void) addAction:(Action *)action {
	[actions addObject:action];
}

- (void) removeAction:(Action *)action {
	[actions removeObject:action];
}

- (Action *) lastAction {
	return [actions lastObject];
}

- (void) removeLastAction {
	[actions removeLastObject];
}

- (NSUInteger) count {
	return [actions count];
}

@end
