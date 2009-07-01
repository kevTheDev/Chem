//
//  Arithmetic.m
//  ChemDraw
//
//  Created by Kevin Edwards on 01/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Arithmetic.h"


@implementation Arithmetic

+ (int)roundFloatDownToInteger:(float)numberToRound {
	
	float roundedValue = round(2.0f * numberToRound) / 2.0f;
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setMaximumFractionDigits:0];
	[formatter setRoundingMode: NSNumberFormatterRoundDown];
	
	NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
	
	[formatter release];
	return [numberString floatValue];;
	
}

@end
