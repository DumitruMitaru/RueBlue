//
//  boxesfortemp.m
//  sliderGame3
//
//  Created by Dumitru Mitaru-berceanu on 12/29/14.
//  Copyright (c) 2014 Dumitru Mitaru-berceanu. All rights reserved.
//

#import "boxesfortemp.h"

@implementation boxesfortemp


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    int number = rand()%4;
    label.text = [NSString stringWithFormat:@"%i", number];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:60];
    
    float degree = rand()%361;
    float radians = (degree/360)*M_PI_2;
    
    label.transform = CGAffineTransformMakeRotation(radians);
    

    
    int i = rand()%2;
    if (i) label.backgroundColor = [UIColor redColor];
    else label.backgroundColor = [UIColor blueColor];
    
    label.layer.cornerRadius = 25;
    label.clipsToBounds = YES;
    
    int randColNum = rand()%4;
    UIColor* shadowColor;
    switch (randColNum) {
        case 0:
            shadowColor = [UIColor yellowColor];
            break;
        case 1:
            shadowColor = [UIColor magentaColor];
            break;
        case 2:
            shadowColor = [UIColor greenColor];
            break;
        case 3:
            shadowColor = [UIColor cyanColor];
            break;

            
        default:
            break;
    }
        [self addSubview:label];
    
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(-5, 5);
    self.layer.shadowOpacity = 1;
    
    self.backgroundColor = [UIColor clearColor]; 
}
@end
