//
//  ActionMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Action;

@interface ActionMap : NSObject {
	NSMutableArray *actions;
}

- (void) addAction:(Action *)action;
- (void) removeAction:(Action *)action;

- (Action *) lastAction;

- (void) removeLastAction;

- (NSUInteger) count;

@end


