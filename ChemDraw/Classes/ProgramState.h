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
#define HIGHLIGHT_POTENTIAL_BOND 2
#define SELECT_POTENTIAL_BOND 3
#define GESTURE_MODE 4
#define TOOLBAR_MODE 5
#define DEBUG_MODE 6


@interface ProgramState : NSObject {
	int currentState;
}

- (ProgramState *) initWithState:(int)startState;


- (char *)currentPrompt;

@property (nonatomic) int currentState;

@end
