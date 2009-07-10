//
//  PointObject.m
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PointObject.h"

#import "Arithmetic.h"

@implementation PointObject

- (PointObject *) initWithPoint:(CGPoint)point {
	
	self = [super init];
	
    if ( self ) {
        
		originalPoint = point;
    }
	
    return self;
	
}

- (CGFloat) x {
	return [self originalPoint].x;
}

- (CGFloat) y {
	return [self originalPoint].y;
}

- (CGPoint) originalPoint {
	return originalPoint;
}

- (NSUInteger)hash {
	
	int x = [Arithmetic roundFloatDownToInteger:[self originalPoint].x];
	int y = [Arithmetic roundFloatDownToInteger:[self originalPoint].y];
	
	NSString *hashString = [NSString stringWithFormat:@"%d%d", x, y];	
	return [hashString intValue];
}

- (BOOL)isEqual:(id)anObject {
	
	if([anObject class] != [self class]) {
		return false;
	}
	
	CGPoint point = [self originalPoint];
	CGPoint testPoint = [anObject originalPoint];
	
	if( (point.x == testPoint.x) && (point.y == testPoint.y) )
		return true;
		
	return false;
}



@end
