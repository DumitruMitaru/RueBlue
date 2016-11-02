//
//  MathForGame.h
//  sliderGame
//
//  Created by Dumitru Mitaru-berceanu on 12/1/14.
//  Copyright (c) 2014 Dumitru Mitaru-berceanu. All rights reserved.
//

#ifndef __sliderGame__MathForGame__
#define __sliderGame__MathForGame__

#include <stdio.h>
#include <CoreFoundation/CoreFoundation.h>
#include <sys/types.h>
#include <CoreGraphics/CoreGraphics.h>


CGPoint translateTransformationOfPointToOrigin(CGPoint point,CGPoint origin);
CGPoint rotatePointAroundCenterByAngle(CGFloat angle, CGPoint point, CGPoint center);
CGFloat distanceBetweenPoints(CGPoint point1, CGPoint point2);
CGFloat angleBetweenPointsWithCenter(CGPoint point1, CGPoint point2, CGPoint center); 
#endif /* defined(__sliderGame__MathForGame__) */
