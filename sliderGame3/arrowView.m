//
//  arrowView.m
//  sliderGame
//
//  Created by Dumitru Mitaru-berceanu on 12/9/14.
//  Copyright (c) 2014 Dumitru Mitaru-berceanu. All rights reserved.
//

#import "arrowView.h"

@implementation arrowView
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawArrowWithContext:context lineWidth:20 arrowHeight:30];
    self.backgroundColor = [UIColor clearColor];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowOffset = CGSizeMake(-9, 4);

     

}
- (void) drawArrowWithContext:(CGContextRef)context lineWidth:(float)width arrowHeight:(float)aheight
{
    float main = self.frame.size.height-aheight;
    CGPoint rectangle_points[] =
    {
        CGPointMake(0, self.frame.size.height/2 - width/2),
        CGPointMake(main, self.frame.size.height/2 - width/2),
        CGPointMake(main, 0),
        CGPointMake(self.frame.size.width, self.frame.size.height/2),
        CGPointMake(main, self.frame.size.height),
        CGPointMake(main, self.frame.size.height/2 + width/2),
        CGPointMake(0, self.frame.size.height/2 + width/2),
       
       
    };
    
    CGContextAddLines(context, rectangle_points, 7);
    
    CGContextFillPath(context);
}
@end
