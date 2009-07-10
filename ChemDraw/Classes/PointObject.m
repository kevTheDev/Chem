//
//  PointObject.m
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PointObject.h"


@implementation PointObject

- (PointObject *) initWithPoint:(CGPoint)point {
	
	self = [super init];
	
    if ( self ) {
        
		originalPoint = point;
    }
	
    return self;
	
}


- (CGPoint) originalPoint {
	return originalPoint;
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
