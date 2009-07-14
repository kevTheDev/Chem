//
//  CharacterMatch.h
//  ChemDraw
//
//  Created by Kevin Edwards on 14/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CharacterMatch : NSObject {
	NSInteger characterRef;
	CGFloat percentageMatch;
}

- (CharacterMatch *) initWithCharacterRef:(NSInteger)ref percentageMatch:(CGFloat)percentage;
- (NSString *)symbol;

@property NSInteger characterRef;
@property CGFloat percentageMatch;

@end
