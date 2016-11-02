//
//  CenterView.m
//  sliderGame
//
//  Created by Dumitru Mitaru-berceanu on 11/11/14.
//  Copyright (c) 2014 Dumitru Mitaru-berceanu. All rights reserved.
//

#import "CenterView.h"
@interface CenterView ()
@property NSUInteger maximumRightIndex;
@property NSUInteger maximumDownIndex;
@property CGPoint rootpoint;
@property NSMutableArray *arrayOfCenters;

@end


@implementation CenterView
-(id)init{
    self = [super init];
    if (self)  {
        self.arrayOfCenters = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)SpecifyRectSize:(CGSize)size{
    CGFloat HeightSize = size.height;
    CGFloat widthSize = size.width;
    CGFloat centerHeight = self.frame.size.height;
    CGFloat centerWidth = self.frame.size.width;
    
    CGPoint zeroPoint = CGPointMake(centerWidth/2 - widthSize/2, centerHeight/2 - HeightSize/2  );
    NSValue *zeroValue = [NSValue valueWithCGPoint:zeroPoint];
    CGPoint onePoint = CGPointMake(centerWidth/2 + widthSize/2, centerHeight/2 - HeightSize/2);
    NSValue *oneValue = [NSValue valueWithCGPoint:onePoint];
    CGPoint twoPoint = CGPointMake(centerWidth/2 - widthSize/2, centerHeight/2 + HeightSize/2);
    NSValue *twoValue = [NSValue valueWithCGPoint:twoPoint];
    CGPoint threePoint = CGPointMake(centerWidth/2 + widthSize/2, centerHeight/2 + HeightSize/2);
    NSValue *threeValue = [NSValue valueWithCGPoint:threePoint];
    
    [self.arrayOfCenters addObject:zeroValue];
    [self.arrayOfCenters addObject:oneValue];
    [self.arrayOfCenters addObject:twoValue];
    [self.arrayOfCenters addObject:threeValue];
  
    
}

-(CGPoint)ReturnPointForIndex:(NSUInteger)index{
    CGPoint pointToReturn;
    pointToReturn = [[self.arrayOfCenters objectAtIndex:index] CGPointValue]; 
    return pointToReturn;
}
-(UILabel*)ReturnViewAtIndex:(NSUInteger)index{
    CGPoint point = [self ReturnPointForIndex:index];
    UILabel* viewToReturn;
    for (UILabel *subView in self.subviews){
        if (CGPointEqualToPoint(subView.center, point)) {
            viewToReturn = subView;
            break;
        }
    }
    return viewToReturn; 
}

@end
