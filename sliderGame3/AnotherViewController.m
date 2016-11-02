//
//  AnotherViewController.m
//  sliderGame
//
//  Created by Dumitru Mitaru-berceanu on 12/3/14.
//  Copyright (c) 2014 Dumitru Mitaru-berceanu. All rights reserved.
//

#import "AnotherViewController.h"
#import "ViewController.h"
@interface AnotherViewController()
- (IBAction)menuButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;



@property UIPageViewController* pageViewController;
@property NSArray* arrayOfViewControllers;
@property UIViewController* currentView;

@end
@implementation AnotherViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    

    self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.1 blue:0 alpha:1];

    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
    self.pageViewController.delegate = self;
    
    
    UIViewController* firstView = [self.storyboard instantiateViewControllerWithIdentifier:@"one"];
    UIViewController* secondView = [self.storyboard instantiateViewControllerWithIdentifier:@"two"];
    UIViewController* thirdView = [self.storyboard instantiateViewControllerWithIdentifier:@"three"];
    UIViewController* fourthView = [self.storyboard instantiateViewControllerWithIdentifier:@"four"];
    UIViewController* fifthView = [self.storyboard instantiateViewControllerWithIdentifier:@"five"];
    UIViewController* sixthView = [self.storyboard instantiateViewControllerWithIdentifier:@"six"];
    UIViewController* seventhView = [self.storyboard instantiateViewControllerWithIdentifier:@"seven"];

    
    self.arrayOfViewControllers = [NSArray arrayWithObjects:firstView, secondView, thirdView, fourthView, fifthView, sixthView, seventhView, nil];

    self.currentView = firstView;
    NSArray *viewControllers = [NSArray arrayWithObject:firstView];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.dataSource = self;
    
    [self addChildViewController:self.pageViewController];
    
    [self.view addSubview:self.pageViewController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    self.pageViewController.view.frame = pageViewRect;
    
    [self.pageViewController didMoveToParentViewController:self];
    
    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    // SET UP MENU BUTTON
    
    
    self.menuButton.layer.shadowColor = [UIColor blueColor].CGColor;
    self.menuButton.layer.shadowOffset = CGSizeMake(-5, 5);
    self.menuButton.layer.shadowOpacity = 1;
    self.menuButton.backgroundColor = [UIColor clearColor];

    
}

-(void)viewDidAppear:(BOOL)animated{
 
 

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index =[self.arrayOfViewControllers indexOfObjectIdenticalTo:viewController];
    UIViewController* newController;
    if (index ==0) newController = nil;
    else newController = [self.arrayOfViewControllers objectAtIndex:index-1];
    
    
    
    return  newController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index =[self.arrayOfViewControllers indexOfObjectIdenticalTo:viewController];
    UIViewController* newController;
    if (index>=self.arrayOfViewControllers.count-1) newController = nil;
    else newController = [self.arrayOfViewControllers objectAtIndex:index+1];

    return newController;
}

- (IBAction)menuButtonPressed:(id)sender {
   
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
