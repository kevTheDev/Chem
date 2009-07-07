//
//  PointObjectMap.h
//  ChemDraw
//
//  Created by Kevin Edwards on 07/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PointObject;

@interface PointObjectMap : NSObject {
	NSMutableArray *pointObjects;
}

- (void) addPoint:(PointObject *)pointObject;

- (void) renderWithContext:(CGContextRef)ctx;

- (void) renderLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint withContext:(CGContextRef)ctx;

@end
