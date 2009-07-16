//
//  SingleBondAction.h
//  ChemDraw
//
//  Created by Kevin Edwards on 16/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"

@class Bond;

@interface SingleBondAction : Action {
	Bond *bond;
}

- (SingleBondAction *) initWithBond:(Bond *)initBond;
- (void) undo;

@end
