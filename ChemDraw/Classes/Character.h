//
//  Character.h
//  ChemDraw
//
//  Created by Kevin Edwards on 14/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

# define RESOLUTION 16

# define A 20
# define B 21
# define C 22
# define D 23
# define E 24
# define F 25
# define G 26
# define H 27
# define I 28
# define J 29
# define K 30
# define L 31
# define M 32
# define N 33
# define O 34
# define P 35
# define Q 36
# define R 37
# define S 38
# define T 39
# define U 40
# define V 41
# define W 42
# define X 43
# define Y 44
# define Z 45

@class CharacterMatch;


@interface Character : NSObject {
	
}

+ (CharacterMatch *) getBestMatch:(NSArray *)pointObjects;

+ (NSArray *) characterMatchResultsForPoints:(NSArray *)pointObjects;



+ (CharacterMatch *) compareToPointObjects:(NSArray *)pointObjects withCharacter:(int)characterRef;

+ (CharacterMatch *) matchForA:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForB:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForC:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForD:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForE:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForF:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForG:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForH:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForI:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForJ:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForK:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForL:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForM:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForN:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForO:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForP:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForQ:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForR:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForS:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForT:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForU:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForV:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForW:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForX:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForY:(NSArray *)pointObjects;
+ (CharacterMatch *) matchForZ:(NSArray *)pointObjects;


@end
