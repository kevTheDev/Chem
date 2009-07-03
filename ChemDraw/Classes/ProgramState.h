//
//  ProgramState.h
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FIRST_NODE  0
#define SECOND_NODE 1
#define SELECT_OBJECT 2
#define MANIPULATE_OBJECT 3
#define ADD_NODE 4

@interface ProgramState : NSObject {
	int currentState;
}

- (ProgramState *) initWithState:(int)startState;


- (char *)currentPrompt;

@property int currentState;

@end
