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



@interface Character : NSObject {
	
}

+ (CGFloat) compareToPointObjects:(NSArray *)pointObjects withCharacter:(int)characterRef;

+ (CGFloat) matchForA:(NSArray *)pointObjects;
+ (CGFloat) matchForB:(NSArray *)pointObjects;
+ (CGFloat) matchForC:(NSArray *)pointObjects;
+ (CGFloat) matchForD:(NSArray *)pointObjects;
+ (CGFloat) matchForE:(NSArray *)pointObjects;
+ (CGFloat) matchForF:(NSArray *)pointObjects;
+ (CGFloat) matchForG:(NSArray *)pointObjects;
+ (CGFloat) matchForH:(NSArray *)pointObjects;
+ (CGFloat) matchForI:(NSArray *)pointObjects;
+ (CGFloat) matchForJ:(NSArray *)pointObjects;
+ (CGFloat) matchForK:(NSArray *)pointObjects;
+ (CGFloat) matchForL:(NSArray *)pointObjects;
+ (CGFloat) matchForM:(NSArray *)pointObjects;
+ (CGFloat) matchForN:(NSArray *)pointObjects;
+ (CGFloat) matchForO:(NSArray *)pointObjects;
+ (CGFloat) matchForP:(NSArray *)pointObjects;
+ (CGFloat) matchForQ:(NSArray *)pointObjects;
+ (CGFloat) matchForR:(NSArray *)pointObjects;
+ (CGFloat) matchForS:(NSArray *)pointObjects;
+ (CGFloat) matchForT:(NSArray *)pointObjects;
+ (CGFloat) matchForU:(NSArray *)pointObjects;
+ (CGFloat) matchForV:(NSArray *)pointObjects;
+ (CGFloat) matchForW:(NSArray *)pointObjects;
+ (CGFloat) matchForX:(NSArray *)pointObjects;
+ (CGFloat) matchForY:(NSArray *)pointObjects;
+ (CGFloat) matchForZ:(NSArray *)pointObjects;


@end
