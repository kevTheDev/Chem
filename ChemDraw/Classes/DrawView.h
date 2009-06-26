//
//  DrawView.h
//  ChemDraw
//
//  Created by Kevin Edwards on 26/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Node.h"

@interface DrawView : UIView {
	Node *firstNode;
}

- (void) drawNode:(Node *)node;

@property (nonatomic, retain) Node *firstNode;

@end
