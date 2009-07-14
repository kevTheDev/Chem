//
//  CharacterMatch.m
//  ChemDraw
//
//  Created by Kevin Edwards on 14/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CharacterMatch.h"
#import "Character.h"

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

// TODO - should just have a static hash here
- (NSString *)symbol {
	switch(characterRef) {
				case A: 
					return @"A";
				break;
				case B:
					return @"B";
				break;
				case C:
					return @"C";
				break;
				case D:
					return @"D";
				break;
				case E:
					return @"E";
				break;
				case F:
					return @"F";
				break;
				case G:
					return @"G";
				break;
				case H:
					return @"H";
				break;
				case I:
					return @"I";
				break;
				case J:
					return @"J";
				break;
				case K:
					return @"K";
				break;
				case L:
					return @"L";
				break;
				case M:
					return @"M";
				break;
				case N:
					return @"N";
				break;
				case O:
					return @"O";
				break;
				case P:
					return @"P";
				break;
				case Q:
					return @"Q";
				break;
				case R:
					return @"R";
				break;
				case S:
					return @"S";
				break;
				case T:
					return @"T";
				break;
				case U:
					return @"U";
				break;
				case V:
					return @"V";
				break;
				case W:
					return @"W";
				break;
				case X:
					return @"X";
				break;
				case Y:
					return @"Y";
				break;
				case Z:
					return @"Z";
				break;
				default:
					return @"";
				break;
			
			}

}

@end
