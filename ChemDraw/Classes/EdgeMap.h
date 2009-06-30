//
//  EdgeMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 30/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Edge.h"

@interface EdgeMap : NSObject {
	NSMutableArray *edges;
}

@property (nonatomic, retain) NSMutableArray *edges;

- (EdgeMap *) initWithCapacity:(int)capacity;


@end
