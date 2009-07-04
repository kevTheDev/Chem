//
//  ProgramState.m
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ProgramState.h"


@implementation ProgramState

@synthesize currentState;

- (ProgramState *) init {
	self = [super init];
	
    if ( self ) {
		currentState = SELECT_OBJECT;
    }
	
    return self;
	
}

- (ProgramState *) initWithState:(int)startState {
	self = [super init];
	
    if ( self ) {
		currentState = startState;
    }
	
    return self;
}

- (char *)currentPrompt {
	
	char* prompt = "";
	
	
	switch(currentState) {
		case SELECT_OBJECT:
			prompt = "Touch near an bond or node to manipulate it...";
			break;
		case MANIPULATE_OBJECT:
			prompt = "Touch again to confirm selection";
			break;
		case HIGHLIGHT_POTENTIAL_BOND:
			prompt = "Touch to add another node";
			break;
		case GESTURE_MODE:
			prompt = "Draw a symbol";
			break;
		case TOOLBAR_MODE:
			prompt = "Choose an action";
			break;
		default:
			prompt = "Touch the screen to create the first root node...";
			break;
	}
	
	return prompt;
}

@end
