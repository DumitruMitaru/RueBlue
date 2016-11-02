//
//  SpecialViews.m
//  sliderGame
//
//  Created by Dumitru Mitaru-berceanu on 11/11/14.
//  Copyright (c) 2014 Dumitru Mitaru-berceanu. All rights reserved.
//

#import "SpecialViews.h"


@interface SpecialViews ()
@property CGPoint rootpoint;

@end
@implementation SpecialViews




-(void)setRootPoint:(CGPoint)point{
    self.rootpoint = point;
}
#pragma mark - returnThings

-(CGPoint)ReturnPointForIndex:(NSUInteger)index{
    CGPoint pointToReturn;
    pointToReturn = CGPointMake(self.rootpoint.x+(2 *index*self.rootpoint.x), self.rootpoint.y);
    return pointToReturn; 
}

-(NSUInteger)returnIndexCount{
    NSUInteger indexcount = 0;
    
   CGPoint nextpoint = self.rootpoint;
    
        while ([self pointInside:nextpoint withEvent:nil]){
        indexcount++;
        nextpoint = CGPointMake(self.rootpoint.x + (2*indexcount*self.rootpoint.x), self.rootpoint.y);
    }
    return indexcount;
}


-(Boxes*)returnObjectForIndex:(NSUInteger)index{
    Boxes* objectToReturn;
    CGPoint ObjectCenter = [self ReturnPointForIndex:index];
    
    for (Boxes *subview in self.subviews){
        if (CGPointEqualToPoint(ObjectCenter, subview.center)) {
            objectToReturn = subview;
            break;
        }
    }
    return objectToReturn; 
}

-(Boxes*)returnObjectFarthestAwayFromSwipeDirection{
    Boxes *objectToReturn;
    NSUInteger indexer;
    if (self.swipeRight) {
    
                indexer = ([self returnIndexCount] -1 );
                CGPoint centerOfView3 = [self ReturnPointForIndex:indexer];
                for (Boxes *view in self.subviews){
                    if (CGPointEqualToPoint(view.center, centerOfView3)) {
                        objectToReturn = view;
                        break;
                    }
                }
    }
    
    else{
                    indexer = 0;
                    CGPoint centerOfView4 = [self ReturnPointForIndex:indexer];
                    for (Boxes *view in self.subviews){
                        if (CGPointEqualToPoint(view.center, centerOfView4)) {
                            objectToReturn = view;
                            break;
                        }
                    }
    }

    return objectToReturn;
}
@end
