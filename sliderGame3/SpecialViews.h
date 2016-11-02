//
//  SpecialViews.h
//  sliderGame
//
//  Created by Dumitru Mitaru-berceanu on 11/11/14.
//  Copyright (c) 2014 Dumitru Mitaru-berceanu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Boxes.h"




@interface SpecialViews : UIView

@property NSUInteger numberOfIndexs;
@property BOOL swipeRight;

-(void)setRootPoint:(CGPoint)point;

-(CGPoint)ReturnPointForIndex:(NSUInteger)index;

-(Boxes*)returnObjectFarthestAwayFromSwipeDirection;

-(Boxes*)returnObjectForIndex:(NSUInteger)index;

-(NSUInteger)returnIndexCount; 

@end
