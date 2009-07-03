//
//  ProgramState.h
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SELECT_OBJECT 0
#define MANIPULATE_OBJECT 1
#define ADD_NODE 2
#define GESTURE_MODE 3
#define TOOLBAR_MODE 4

@interface ProgramState : NSObject {
	int currentState;
}

- (ProgramState *) initWithState:(int)startState;


- (char *)currentPrompt;

@property int currentState;

@end
