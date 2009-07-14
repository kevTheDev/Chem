//
//  CharacterMatch.m
//  ChemDraw
//
//  Created by Kevin Edwards on 14/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CharacterMatch.h"

@implementation CharacterMatch

@synthesize characterRef;
@synthesize percentageMatch;

- (CharacterMatch *) initWithCharacterRef:(NSInteger)ref percentageMatch:(CGFloat)percentage {
	self = [super init];
	
	if(self) {
		characterRef = ref;
		percentageMatch = percentage;
		
	}
	
	return self;

}

@end
