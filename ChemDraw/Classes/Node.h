//
//  Node.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Node : NSObject {
	CGFloat xCoord;
	CGFloat yCoord;
	
	BOOL unconfirmedHighlight;
	BOOL confirmedHighlight;
}

- (Node *) initWithXCoord:(CGFloat)x yCoord:(CGFloat)y;


@property CGFloat xCoord;
@property CGFloat yCoord;

@property BOOL unconfirmedHighlight;
@property BOOL confirmedHighlight;

@end
