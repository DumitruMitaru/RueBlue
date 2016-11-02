//
//  Boxes.m
//  sliderGame
//
//  Created by Dumitru Mitaru-berceanu on 12/8/14.
//  Copyright (c) 2014 Dumitru Mitaru-berceanu. All rights reserved.
//

#import "Boxes.h"

@implementation Boxes


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.label = [[UILabel alloc] initWithFrame:frame];
        [self addSubview:self.label];
    }
    return  self;
}


@end
