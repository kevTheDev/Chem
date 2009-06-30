//
//  NodeTest.m
//  ChemDraw
//
//  Created by Kevin Edwards on 30/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

#import "Node.h"

@interface NodeTest : SenTestCase {
	
	Node *node;
	
}

@end

@implementation NodeTest

- (void) setUp {
	
	node = [[Node alloc] initWithXCoord:10.0 yCoord:15.0];
	
}

- (void) testInitXCoord {
	STAssertEquals((float) [node xCoord], 10.0f, nil);
}


- (void) testInitYCoord {
	STAssertEquals((float) [node yCoord], 15.0f, nil);
}

- (void) tearDown {
	
	[node release];
	
}


@end
