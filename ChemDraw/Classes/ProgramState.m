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
		currentState = FIRST_NODE;
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
		case FIRST_NODE:
			prompt = "Touch the screen again to form an bond...";
			//prompt = "Touch the screen to create the first root node...";
			break;
		case SECOND_NODE:
			prompt = "Touch the screen again to form an bond...";
			//prompt = "Touch near an bond or node to manipulate it...";
			break;
		case SELECT_OBJECT:
			prompt = "Touch near an bond or node to manipulate it...";
//			prompt = "Touch again to confirm selection";
			break;
		case MANIPULATE_OBJECT:
			prompt = "Touch again to confirm selection";
//			prompt = "Choose your action from the toolbar";
			break;
		case ADD_NODE:
			prompt = "Touch to add another node";
			break;
		default:
			prompt = "Touch the screen to create the first root node...";
			break;
	}
	
	return prompt;
}

@end
