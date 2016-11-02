//
//  CenterView.h
//  sliderGame
//
//  Created by Dumitru Mitaru-berceanu on 11/11/14.
//  Copyright (c) 2014 Dumitru Mitaru-berceanu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpecialViews.h"
#import "Boxes.h"


@interface CenterView : UIView
-(void)SpecifyRectSize:(CGSize)size;
-(CGPoint)ReturnPointForIndex:(NSUInteger)index;
-(UILabel*)ReturnViewAtIndex:(NSUInteger)index;
-(id)init; 
@end
