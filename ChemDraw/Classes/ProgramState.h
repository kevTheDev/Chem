//
//  ProgramState.h
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ProgramState : NSObject {
	int currentState;
}

- (ProgramState *) initWithState:(int)startState;

- (void) setCurrentState:(int)newState;

- (char *)currentPrompt;

@end
