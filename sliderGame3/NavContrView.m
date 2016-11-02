//
//  NavContrView.m
//  sliderGame3
//
//  Created by Dumitru Mitaru-berceanu on 12/23/14.
//  Copyright (c) 2014 Dumitru Mitaru-berceanu. All rights reserved.
//

#import "NavContrView.h"


@interface NavContrView()
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIView *playBack;
@property (weak, nonatomic) IBOutlet UIButton *howToButton;
@property (weak, nonatomic) IBOutlet UIView *howToBack;
@property (strong) AnotherViewController* howToCont;



@end

@implementation NavContrView

-(void)viewDidLoad{

    [super viewDidLoad];
    self.howToCont = [self.storyboard instantiateViewControllerWithIdentifier:@"howToPlayCont"];

     

    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  /*  [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new]; 
    self.navigationController.navigationBar.translucent = YES;*/
    
    //self.navigationController.navigationBar.hidden = YES;
    [   self.navigationController.navigationBar removeFromSuperview];
    self.playButton.backgroundColor = [UIColor redColor];
    self.playButton.layer.cornerRadius = 25;
    [self.playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.playButton.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    self.playButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.howToButton.backgroundColor = [UIColor redColor];
    self.howToButton.layer.cornerRadius = 25;
    [self.howToButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal]; 
    self.howToButton.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    self.howToButton.titleLabel.textAlignment = NSTextAlignmentCenter; 
    
    
    self.playBack.backgroundColor = [UIColor clearColor];
    self.playBack.layer.shadowOffset = CGSizeMake(-5, 5);
    self.playBack.layer.shadowOpacity = 1;
    self.playBack.layer.shadowColor = [UIColor blueColor].CGColor;
    
    self.howToBack.backgroundColor = [UIColor clearColor];
    self.howToBack.layer.shadowOffset = CGSizeMake(-5, 5);
    self.howToBack.layer.shadowOpacity = 1;
    self.howToBack.layer.shadowColor = [UIColor blueColor].CGColor;
    
    
  
    
}


@end
