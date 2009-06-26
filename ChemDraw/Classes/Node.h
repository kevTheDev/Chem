//
//  Node.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Node : NSObject {
	int xCoord;
	int yCoord;
}

- (Node *) initWithXCoord:(int)x yCoord:(int)y;


@property int xCoord;
@property int yCoord;

@end
