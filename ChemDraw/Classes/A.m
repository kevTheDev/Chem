//
//  A.m
//  ChemDraw
//
//  Created by Kevin Edwards on 14/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "A.h"

#import "PointObject.h"

@implementation A

+ (CGFloat) compareToPointObjects:(NSArray *)pointObjects {
	
	int pixelCheck;
	
	
	int a[256] = {
	
		0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,
		0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,
		0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
		0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,
		0,0,0,0,1,1,1,0,0,1,1,1,0,0,0,0,
		0,0,0,0,1,1,1,0,0,1,1,1,0,0,0,0,
		0,0,0,1,1,1,0,0,0,0,1,1,1,0,0,0,
		0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,
		0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
		0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
		0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,
		0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,
		1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
		1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1		

				
	};
	

	
	int *ptr;
	
	float lineCount = 0;
	float linePercentage = 0;

	float totalPercentage = 0;
	
	NSMutableString *debugString = [[NSMutableString alloc] init];
	NSString *ON = @"1 ";
	NSString *OFF = @"0 ";
	NSString *newLine = @"\n";
							
	[debugString appendString:newLine];												
																									
	for(int y=0; y<RESOLUTION; y++) {
		for(int x=0; x<RESOLUTION; x++) { //within this loop we are checking on horizontal line at a time
					
			int letterArrayIndex = (y*RESOLUTION) + x;
		
			ptr = &a[letterArrayIndex];		
			pixelCheck = a[letterArrayIndex];
					
			CGPoint point = CGPointMake(x, y);
			PointObject *pointObject = [[PointObject alloc] initWithPoint:point];
			
					
			if( [pointObjects containsObject:pointObject] == YES ) {
			
				[debugString appendString:ON];

				// the compressed point image has an ON PIXEL HERE
				if(pixelCheck == 1) { // the a character has an ON pixel at this point
					lineCount++;
				}

			}
			else { // the compressed point image has an OFF PIXEL HERE
				
				[debugString appendString:OFF];
				
				
				if(pixelCheck == 0) { // the a character has an OFF pixel at this point
					lineCount++;
				}
		
			}
			
			[pointObject release];
					
			
	
		} // end of row loop
		
		[debugString appendString:newLine];
				
		linePercentage = (lineCount / RESOLUTION) * 100;
		totalPercentage += linePercentage;

		NSLog(@"LINE PERCENTAGE FOR LINE %d: %f", y, linePercentage);
		
		linePercentage = 0;
		lineCount = 0;
		
	} // end of column loop
		

	totalPercentage = totalPercentage / RESOLUTION;	



	NSLog(@"Final A: %f%", totalPercentage);
	
	NSLog(@"%@", debugString);
	
	return totalPercentage;

}


@end
