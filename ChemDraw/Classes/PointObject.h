//
//  PointObject.h
//  ChemDraw
//
//  Created by Kevin Edwards on 03/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <ApplicationServices/ApplicationServices.h>

@interface PointObject : NSObject {

	CGPoint originalPoint;
}

- (PointObject *) initWithPoint:(CGPoint)point;

- (CGPoint) originalPoint;

- (CGFloat) x;
- (CGFloat) y;

@end
