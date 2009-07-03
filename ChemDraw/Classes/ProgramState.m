//
//  ProgramState.m
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ProgramState.h"

#define START_STATE 0
#define FIRST_NODE  1
#define MAIN        2
#define CONFIRM     3

@implementation ProgramState

- (ProgramState *) init {
	self = [super init];
	
    if ( self ) {
		currentState = START_STATE;
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

- (void) setCurrentState:(int)newState {
	currentState = newState;
}

- (char *)currentPrompt {
	
	//char* prompt = "";
//	
//	NSLog(@"CURRENT PROMPT");
//	
//	switch(currentState) {
//		case START_STATE:
//			prompt = "Touch the screen to create the first root node...";
//			break;
//		case FIRST_NODE:
//			prompt = "Touch the screen again to form an edge...";
//			break;
//		case SECOND_NODE:
//			
//		case MAIN:
//			prompt = "Touch near an edge or node to manipulate it...";
//			break:
//		case CONFIRM:
//			break;
//		default:
//			prompt = "No Prompt";
//			break;
//	}
//	
//	return prompt;
	
	return "";
}

@end
