//
//  ProgramState.m
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ProgramState.h"

#define START_STATE 0

@implementation ProgramState

- init {
	self = [super init];
	
    if ( self ) {
		currentState = START_STATE;
    }
	
    return self;
	
}

- initWithState:(int)startState {
	self = [super init];
	
    if ( self ) {
		currentState = startState;
    }
	
    return self;
}

- (char *)currentPrompt {
	
	char* prompt = "";
	
	NSLog(@"CURRENT PROMPT");
	
	switch(currentState) {
		case START_STATE:
			prompt = "Touch the screen to create the first root node...";
			break;
		default:
			prompt = "No Prompt";
			break;
	}
	
	return prompt;
}

@end
