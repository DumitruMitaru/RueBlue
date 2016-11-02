//
//  MathForGame.c
//  sliderGame
//
//  Created by Dumitru Mitaru-berceanu on 12/1/14.
//  Copyright (c) 2014 Dumitru Mitaru-berceanu. All rights reserved.
//

#include "MathForGame.h"


CGPoint translateTransformationOfPointToOrigin(CGPoint point, CGPoint newOrigin){
    
    
    CGPoint pointToReturn = CGPointMake(point.x - newOrigin.x, point.y - newOrigin.y);
    
    
    return pointToReturn;
    
}
CGFloat distanceBetweenPoints(CGPoint point1, CGPoint point2){
    CGFloat xdistance = point1.x - point2.x;
    CGFloat ydistance = point1.y - point2.y;
    CGFloat totalDist = sqrt(xdistance*xdistance +ydistance*ydistance);
    return totalDist;
}
CGPoint rotatePointAroundCenterByAngle(CGFloat angle, CGPoint point, CGPoint center){
    
    CGPoint pointToReturn;
    
    CGFloat radius = distanceBetweenPoints(point, center);
    
    CGFloat theta = angleBetweenPointsWithCenter( point, CGPointMake(center.x, (center.y)*7/4), center);
    
    CGFloat newTheta = theta + angle;
    
    CGFloat newX = radius * sinf(newTheta);

    
    CGFloat newY = radius * cosf(newTheta);

    
    
    CGPoint newPoint = CGPointMake(newX, newY);
    
    pointToReturn = CGPointMake(newPoint.x + center.x, newPoint.y + center.y);
    
    
    return pointToReturn;
}
CGFloat angleBetweenPointsWithCenter(CGPoint point1, CGPoint point2, CGPoint center){
    
    CGFloat a = point1.x - center.x;
    CGFloat b = point1.y - center.y;
    CGFloat c = point2.x - center.x;
    CGFloat d = point2.y - center.y;
    
    CGFloat atanA = atan2(a, b);
    if (atanA<0) atanA = atanA +(2*M_PI);

    CGFloat atanB = atan2(c, d);
    if (atanB<0) atanB = atanB +(2*M_PI);

    return (atanA - atanB);// * 180 / M_PI ;
}

