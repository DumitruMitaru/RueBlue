//
//  ViewController.m
//  sliderGame
//
//  Created by Dumitru Mitaru-berceanu on 11/11/14.
//  Copyright (c) 2014 Dumitru Mitaru-berceanu. All rights reserved.
//

#import "ViewController.h"
#include "MathForGame.h"

typedef enum {
    solved,
    goneOver,
    goneNegative,
    
} stateOfGame;


@interface ViewController ()
{
    float ratio;
    
    float heightwidthaverage;
    NSUInteger numberOfBoxesToHold;
    float XcenterViewOrigin;
    float YcenterViewOrigin;
    float WidthcenterView;
    float HeightcenterView;
    float heightOfBoxes;
    float widthOfBoxes;
    CGPoint centerOfBoxes;
    float columnHeight;
    float columnWidth;
    UIColor *redColor;
    UIColor *blueColor;
    
}
@property IBOutlet CenterView *centerView;
@property NSInteger limitNumber;
@property IBOutlet UILabel *levelLabel;
- (IBAction)mainMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;


@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    //SET UP   menubutton
    
    
    self.menuButton.layer.shadowColor = [UIColor blueColor].CGColor;
    self.menuButton.layer.shadowOffset = CGSizeMake(-5, 5);
    self.menuButton.layer.shadowOpacity = 1;
    self.menuButton.backgroundColor = [UIColor clearColor];

    
   //SET UP levelLabel holder
    UIView* viewHolderForlevelLabel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3, self.view.frame.size.height/5)];
    viewHolderForlevelLabel.center = CGPointMake(self.view.bounds.size.width/2, viewHolderForlevelLabel.frame.size.height/2);
    viewHolderForlevelLabel.backgroundColor = [UIColor clearColor];
    viewHolderForlevelLabel.layer.shadowOffset = CGSizeMake(-5, 5);
    viewHolderForlevelLabel.layer.shadowColor = [UIColor blueColor].CGColor;
    viewHolderForlevelLabel.layer.shadowOpacity = 1;
    [self.view addSubview:viewHolderForlevelLabel];
    
    
    //SET UP levelLabel
    
    self.levelLabel = [[UILabel alloc] init];
    self.levelLabel.frame = CGRectMake(0, 0, viewHolderForlevelLabel.frame.size.width, viewHolderForlevelLabel.frame.size.height);
    self.levelLabel.center = CGPointMake(viewHolderForlevelLabel.frame.size.width/2, viewHolderForlevelLabel.frame.size.height/2);
   // self.levelLabel.layer.borderWidth = 4;
   // self.levelLabel.layer.borderColor = [UIColor blueColor].CGColor;
    self.levelLabel.font = [UIFont systemFontOfSize:40];
    self.levelLabel.textAlignment = NSTextAlignmentCenter;
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    self.limitNumber = [[defaults objectForKey:@"Level"] integerValue];
    if (!self.limitNumber) self.limitNumber = 2;

    
    [self upDateLevelLabelToLevel];
    self.levelLabel.tag = 1;
    self.levelLabel.backgroundColor = [UIColor redColor];
    self.levelLabel.textColor = [UIColor blueColor];
    self.levelLabel.layer.cornerRadius = 25;
    self.levelLabel.clipsToBounds = YES;
   [viewHolderForlevelLabel addSubview:self.levelLabel];
    
    // SET UP SELF.VIEW
    self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.1 blue:0 alpha:1];
    
    //Declare the Colors
    redColor = [UIColor redColor];
    blueColor = [UIColor blueColor];
    
    //  DECLARE THE RATIO
    ratio = 0.35;
    numberOfBoxesToHold = 3;
    heightwidthaverage = (self.view.frame.size.width>=500) ? 1000*ratio/2: 900*ratio/2;
    
    
    // SETUP CENTER VIEW
    self.centerView = [[CenterView alloc] init];
    self.centerView.frame = CGRectMake(0, 0, heightwidthaverage, heightwidthaverage);
    self.centerView.layer.borderWidth = 9;
    self.centerView.layer.borderColor = redColor.CGColor;
    self.centerView.layer.cornerRadius = 10;
    self.centerView.center = self.view.center;
    self.centerView.tag = 10;
    self.centerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.centerView.layer.shadowOpacity =1;
    self.centerView.layer.shadowOffset = CGSizeMake(-5, 5);
  //  [self.centerView setGlowViewToCurrentStateWithColor:[UIColor whiteColor]];
    
    
    [self.view addSubview:self.centerView];
    
    
    // DEFINE SOME NUMBERS FOR FUTURE USE
    HeightcenterView = self.centerView.frame.size.height;
    WidthcenterView = self.centerView.frame.size.width;
    XcenterViewOrigin = self.centerView.frame.origin.x;
    YcenterViewOrigin = self.centerView.frame.origin.y;
    
    [self.centerView SpecifyRectSize:CGSizeMake(WidthcenterView/2, HeightcenterView/2)];
    
    //SET UP FRAMES FOR BOXES
    heightOfBoxes = HeightcenterView/2;
    widthOfBoxes = WidthcenterView/2;
    centerOfBoxes = CGPointMake(widthOfBoxes/2-10, heightOfBoxes/2);
    
    
    //SET UP Width AND HEIGHT OF COLUMNS
    columnHeight = heightOfBoxes;//heightOfBoxes * numberOfBoxesToHold;
    columnWidth = 2*centerOfBoxes.x * numberOfBoxesToHold; //widthOfBoxes;
    
    
    //  SETUP SPECIAL VIEWS
    for (NSUInteger i = 0; i<4; i++){
        SpecialViews *specialView = [[SpecialViews alloc] init];
        // specialView.layer.borderWidth = 1;
        // specialView.layer.borderColor  = [UIColor greenColor].CGColor;
        specialView.tag = i;
        [specialView setRootPoint:centerOfBoxes];
        switch (i) {
                
            case 0:
                specialView.frame = CGRectMake(XcenterViewOrigin - columnWidth, YcenterViewOrigin, columnWidth, columnHeight);
                specialView.swipeRight = YES;
                break;
                
            case 1:
                specialView.frame = CGRectMake(XcenterViewOrigin - columnWidth, YcenterViewOrigin+HeightcenterView/2, columnWidth, columnHeight);
                specialView.swipeRight = YES;
                break;
            case 2:
                specialView.frame = CGRectMake(XcenterViewOrigin+WidthcenterView, YcenterViewOrigin, columnWidth, columnHeight);
                specialView.swipeRight = NO;
                break;
            case 3:
                specialView.frame = CGRectMake(XcenterViewOrigin + WidthcenterView, YcenterViewOrigin + HeightcenterView/2, columnWidth, columnHeight);
                specialView.swipeRight = NO;
                break;
                
            default:
                break;
                
        }
        [self.view addSubview:specialView];
    }
    srand(time(NULL));
    [self FILLALLSpecialViewWithBoxes];
    [self FillCenterViewWithBoxes];
    [self AddSwipeGestureToView];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  GENERAL GAME METHODS
-(void)Restart{
    for (UIView* views in self.centerView.subviews){
        [views removeFromSuperview]; }
    for ( NSUInteger i = 0; i<4; i++){
        SpecialViews *specialview = [self returnSpecialViewInViewControllerViewWithTag:i];
        for (UILabel* subviews in specialview.subviews){
            [subviews removeFromSuperview];
        }
    }
    [self FillCenterViewWithBoxes];
    [self FILLALLSpecialViewWithBoxes];
    [self.levelLabel stopGlowing];
    [self.centerView stopGlowing];
}

-(void)advanceOrFailIfPossible{
    int64_t delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    if ([self CheckIfGoneOver]){
        
        [self fadeOutLabelForStateOfGame:goneOver];
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [self Restart];
            
        });
        return;
    }
    if ([self CheckIfSolved]){
        self.limitNumber++;
        [self fadeOutLabelForStateOfGame:solved];
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [self Restart];
            [self.centerView stopColoringWithFinalColor:[UIColor blackColor]];
            [self.levelLabel.superview stopColoringWithFinalColor:blueColor];
            [self upDateLevelLabelToLevel];
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:[NSNumber numberWithInteger:self.limitNumber] forKey:@"Level"];
            
        });
        
        return;
    }
    if ([self didGoNegative]) {
        [self fadeOutLabelForStateOfGame:goneNegative];
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [self Restart];
            
        });
        return;
        
    }
}

-(BOOL)CheckIfSolved{
    BOOL didSolve = YES;
    for (UILabel *labels in self.centerView.subviews){
        float numberOnlabel = labels.text.floatValue;
        if (numberOnlabel != self.limitNumber) {
            didSolve = NO;
            break;
        }
    }
    if (didSolve){
        NSMutableArray *arrayofLabels = [[NSMutableArray alloc] init];
        for (UIView *labels in self.centerView.subviews){
            
            [labels startWiggling];
            
        }
        for (NSUInteger i=0; i<4; i++){
            SpecialViews *specView = [self returnSpecialViewInViewControllerViewWithTag:i];
            for (UILabel *label in specView.subviews){
                [arrayofLabels addObject:label];
            }
        }
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *labels in arrayofLabels){
                labels.alpha = 0;
            }
            
        }];
        //[self.levelLabel startGlowing];
       // [self.centerView startGlowing];
        [self.centerView startColoring];
        [self.levelLabel.superview startColoring];
    }
    return didSolve;
    
}
-(BOOL)CheckIfGoneOver{
    BOOL goneOver = NO;
    for (UILabel *labels in self.centerView.subviews){
        float numberOnlabel = labels.text.floatValue;
        if (numberOnlabel > self.limitNumber){
            [labels startWiggling];
            goneOver = YES;
            break;
        }
    }
    return goneOver;
    
}
-(BOOL)didGoNegative{
    BOOL wentNegative = NO;
    for (UILabel *labels in self.centerView.subviews){
        float numberOnlabel = labels.text.floatValue;
        if (numberOnlabel < 0){
            [labels startWiggling];
            wentNegative = YES;
            break;
        }
    }
    return wentNegative;
    
}

-(void)fadeOutLabelForStateOfGame:(stateOfGame)state{
    UILabel *fadeOutLabelForAdvance = [[UILabel alloc] init];
    fadeOutLabelForAdvance.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/4);
    fadeOutLabelForAdvance.center = CGPointMake(self.view.center.x, self.view.frame.size.height - fadeOutLabelForAdvance.frame.size.height/2);
    fadeOutLabelForAdvance.backgroundColor = [UIColor whiteColor];
    fadeOutLabelForAdvance.textAlignment = NSTextAlignmentCenter;
    fadeOutLabelForAdvance.font = [UIFont boldSystemFontOfSize:30];
    fadeOutLabelForAdvance.numberOfLines = 2;
    switch (state) {
        case solved:
            fadeOutLabelForAdvance.text = [NSString stringWithFormat:@"Congratulations, On To Level %li", (long)self.limitNumber];
            
            break;
        case goneOver:
            fadeOutLabelForAdvance.text = [NSString stringWithFormat:@"Whoops, Don't Go over %li", (long)self.limitNumber];
            
            break;
        case goneNegative:
            fadeOutLabelForAdvance.text = @"Don't Go Negative";
            break;
        default:
            break;
    }
    
    [self.view addSubview:fadeOutLabelForAdvance];
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:4 animations:^{ fadeOutLabelForAdvance.alpha = 0;} completion:^(BOOL finished){
        if (finished) [fadeOutLabelForAdvance removeFromSuperview];
        self.view.userInteractionEnabled = YES;
    }];
    
}

-(void)upDateLevelLabelToLevel{
    self.levelLabel.text = [NSString stringWithFormat:@"LEVEL %lu", (long)self.limitNumber];
    
}
#pragma mark - SWIPE GESTURES CALLS THIS METHOD

-(void)SpecialViewWasSwipedWithTag:(NSUInteger)tag{
    self.view.userInteractionEnabled = NO;
    
    NSTimeInterval animationduration = 0.15;
    SpecialViews *specialViewWithTag = [self returnSpecialViewInViewControllerViewWithTag:tag];
    Boxes *labelToTranser = [specialViewWithTag returnObjectFarthestAwayFromSwipeDirection];
    UILabel *centerLabelToShift;
    UILabel *centerLabelStatic;
    BOOL shiftRight;
    NSUInteger IndexOfCenterViewForTranferLabel;
    switch (tag) {
        case 0:{
            
            centerLabelToShift = (UILabel*)[self.centerView ReturnViewAtIndex:0];
            centerLabelStatic = (UILabel*)[self.centerView ReturnViewAtIndex:1];
            IndexOfCenterViewForTranferLabel = 0;
            shiftRight = YES;
            
            break;
        }
        case 1:{
            
            centerLabelToShift = [self.centerView ReturnViewAtIndex:2];
            centerLabelStatic = [self.centerView ReturnViewAtIndex:3];
            IndexOfCenterViewForTranferLabel = 2;
            shiftRight = YES;
            break;
        }
        case 2:{
            centerLabelToShift = [self.centerView ReturnViewAtIndex:1];
            centerLabelStatic = [self.centerView ReturnViewAtIndex:0];
            IndexOfCenterViewForTranferLabel = 1;
            shiftRight = NO;
            break;
        }
        case 3:{
            centerLabelToShift = [self.centerView ReturnViewAtIndex:3];
            centerLabelStatic = [self.centerView ReturnViewAtIndex:2];
            IndexOfCenterViewForTranferLabel = 3;
            shiftRight = NO;
            break;
        }
        default:{
            break;
        }
    }
    [self AddTransferLabel:labelToTranser toSuperFromSpecial:specialViewWithTag];
    Boxes *randoBox = [self returnRandomBox];
    
    [UIView animateWithDuration:animationduration animations:^{
        [self ShiftCenterLabel:centerLabelToShift toStaticLabel:centerLabelStatic];}
                     completion:^(BOOL finished){
                         if (finished){
                             [self UpdateLabelWithMathPerformedOnShiftingLabel:centerLabelToShift andStaticLabel:centerLabelStatic];
                             [UIView animateWithDuration:animationduration animations:^{
                                 [self TransferNextLabel:labelToTranser IntoCenterForCenterIndex:IndexOfCenterViewForTranferLabel fromSpecialView:specialViewWithTag];
                                 if (shiftRight) [self ShiftViewsRightInViewForTag:tag];
                                 else [self ShiftViewLeftInViewForTag:tag];
                                 self.centerView.layer.borderColor = (labelToTranser.label.tag) ? redColor.CGColor : blueColor.CGColor;
                                 
                                 
                             }
                                              completion:^(BOOL finished){
                                                  
                                                  [self AddLabelToTransferToCenterView:labelToTranser];
                                                  
                                                  
                                                  self.view.userInteractionEnabled = YES;
                                                  [self advanceOrFailIfPossible];
                                              }];
                             [self AddRandomBox:randoBox ToTheBackOfSpecialView:specialViewWithTag];
                         }
                     }];
    
    
}

#pragma mark - SPECIAL VIEW METHODS

-(SpecialViews *)returnSpecialViewInViewControllerViewWithTag:(NSUInteger)tag{
    SpecialViews *viewToShift;
    for (UIView *subviewsWithTags in self.view.subviews){
        if ((subviewsWithTags.tag == tag)&&[subviewsWithTags isKindOfClass:[SpecialViews class]]) {
            viewToShift = (SpecialViews*)subviewsWithTags;
            break;
        }
    }
    return viewToShift;
}

-(void)ShiftViewLeftInViewForTag:(NSUInteger)tag{
    
    SpecialViews *specialViewToShift = (SpecialViews*)[self returnSpecialViewInViewControllerViewWithTag:tag];
    NSUInteger HowManyIndexes = [specialViewToShift returnIndexCount];
    NSMutableArray *arrayOfViews = [[NSMutableArray alloc] init];
    NSMutableArray *arrayOfCenters =[[NSMutableArray alloc]init];
    for (int i = 0; i<(HowManyIndexes - 1); i++){
        [arrayOfViews addObject:[specialViewToShift returnObjectForIndex:i+1]];
        CGPoint newCenter = [specialViewToShift ReturnPointForIndex:i];
        NSValue *newCenterValue = [NSValue valueWithCGPoint:newCenter];
        [arrayOfCenters addObject:newCenterValue];
    }
    for (int j = 0; j<arrayOfViews.count; j++){
        UIView *view = [arrayOfViews objectAtIndex:j];
        CGPoint center = [[arrayOfCenters objectAtIndex:j] CGPointValue];
        view.center = center;
    }
    
}

-(void)ShiftViewsRightInViewForTag:(NSUInteger)tag{
    SpecialViews *specialViewToShift = (SpecialViews*)[self returnSpecialViewInViewControllerViewWithTag:tag];
    NSUInteger HowManyIndexes = [specialViewToShift returnIndexCount];
    NSMutableArray *arrayOfViews = [[NSMutableArray alloc] init];
    NSMutableArray *arrayOfCenters =[[NSMutableArray alloc]init];
    for (int i = 0; i<(HowManyIndexes-1); i++){
        [arrayOfViews addObject:[specialViewToShift returnObjectForIndex:i]];
        CGPoint newCenter = [specialViewToShift ReturnPointForIndex:i+1];
        NSValue *newCenterNumber = [NSValue valueWithCGPoint:newCenter];
        [arrayOfCenters addObject:newCenterNumber];
    }
    for (int j = 0; j<arrayOfViews.count; j++){
        UIView *view = [arrayOfViews objectAtIndex:j];
        CGPoint center = [[arrayOfCenters objectAtIndex:j] CGPointValue];
        view.center = center;
    }
    
}
-(void)FillSpecialViewWithBoxes:(SpecialViews*)specialView{
    NSUInteger indexCount11 = [specialView returnIndexCount];
    for (NSUInteger i = 0; i<indexCount11; i++){
        Boxes *view = [self returnRandomBox];
        view.center = [specialView ReturnPointForIndex:i];
        if (specialView.tag ==0 ){
            view.label.text = [NSString stringWithFormat:@"%li", (long)self.limitNumber];
        }
        [specialView addSubview:view];
    }
}

-(void)FILLALLSpecialViewWithBoxes{
    for (NSUInteger i = 0; i<4; i++){
        SpecialViews *myspecialview = [self returnSpecialViewInViewControllerViewWithTag:i];
        [self FillSpecialViewWithBoxes:myspecialview];
    }
    
}





#pragma mark - CenterLabels Methods CENTER LABELS METHODS

-(void)ShiftCenterLabel:(UILabel*)centerLabel toStaticLabel:(UILabel*)staticLabel{
    [centerLabel.superview bringSubviewToFront:centerLabel];
    
    centerLabel.center = staticLabel.center;
    
}
-(void)UpdateLabelWithMathPerformedOnShiftingLabel:(UILabel*)shiftingLabel andStaticLabel:(UILabel*)StaticLabel{
    
    NSInteger integerOne = shiftingLabel.text.integerValue;
    NSInteger integerTwo = StaticLabel.text.integerValue;
    NSInteger sum;
    if (shiftingLabel.tag == StaticLabel.tag){
        sum = integerOne + integerTwo;
        
    }
    else {
        sum = integerTwo - integerOne;
        
    }
    if (shiftingLabel.tag) shiftingLabel.backgroundColor = redColor;
    else shiftingLabel.backgroundColor = blueColor;
    shiftingLabel.text = [NSString stringWithFormat:@"%li", (long)sum];
    [StaticLabel removeFromSuperview];
}



-(void)FillCenterViewWithBoxes{
    for (NSUInteger i=0; i<4; i++){
        Boxes *box = [self returnRandomBox];
        UILabel *label = box.label;
        label.center = [self.centerView ReturnPointForIndex:i];
        
        [self.centerView addSubview:label];
    }
}

#pragma mark - TransferLabel Methods TRANSFER LABEL METHODS

-(void)AddTransferLabel:(Boxes*)transferLabel toSuperFromSpecial:(SpecialViews*)myspecialView{
    
    CGPoint newCenter = [myspecialView convertPoint:transferLabel.center toView:myspecialView.superview];
    [myspecialView.superview addSubview:transferLabel];
    transferLabel.center = newCenter;
    
}
-(void)TransferNextLabel:(Boxes*)labelToTransfer IntoCenterForCenterIndex:(NSUInteger)index fromSpecialView:(SpecialViews*)mySpecialView{
    [self.view bringSubviewToFront:labelToTransfer];
    CGPoint centerOfLabelInSup = [self.centerView convertPoint:[self.centerView ReturnPointForIndex:index] toView:self.view];
    labelToTransfer.center = centerOfLabelInSup;
}
-(void)AddLabelToTransferToCenterView:(Boxes*)labelToTransfer{
    CGPoint newCenter = [self.view convertPoint:labelToTransfer.center toView:self.centerView];
    UILabel* importantLabel = labelToTransfer.label;
    importantLabel.center = newCenter;
    
    [self.centerView addSubview:importantLabel];
    [labelToTransfer removeFromSuperview];
}
#pragma mark - Random BOX Generator
-(Boxes*)returnRandomBox{
    Boxes *boxToReturn = [[Boxes alloc] initWithFrame:CGRectMake(0, 0, widthOfBoxes - 30, heightOfBoxes - 30)];
    NSUInteger redOrBlueNumber = rand() %2;
    int mathNumber = rand()%(self.limitNumber);
    if (redOrBlueNumber){
        boxToReturn.label.tag = 1;
        boxToReturn.label.backgroundColor = redColor;
        
    }
    else {
        boxToReturn.label.tag = 0;
        boxToReturn.label.backgroundColor = blueColor;
    }
    
    boxToReturn.label.layer.cornerRadius = 25;
    boxToReturn.label.clipsToBounds = YES;
    
    
    boxToReturn.layer.shadowOffset = CGSizeMake(-5, 5);
    boxToReturn.layer.shadowOpacity =1;
    boxToReturn.layer.shadowColor = [UIColor blackColor].CGColor;
    boxToReturn.backgroundColor = [UIColor clearColor];
    
    
    boxToReturn.label.textAlignment = NSTextAlignmentCenter;
    boxToReturn.label.text = [NSString stringWithFormat:@"%i", mathNumber];
    boxToReturn.label.font = [UIFont boldSystemFontOfSize:40];
    boxToReturn.label.textColor = [UIColor blackColor];
    return  boxToReturn;
}
-(void)AddRandomBox:(Boxes*)randomBox ToTheBackOfSpecialView:(SpecialViews*)specialViewtoAccept{
    if ((specialViewtoAccept.tag == 0)){
        randomBox.label.text = [NSString stringWithFormat:@"%li", (long)self.limitNumber];
    }
    NSUInteger indexCount = [specialViewtoAccept returnIndexCount];
    if (specialViewtoAccept.swipeRight == YES){
        randomBox.center = [specialViewtoAccept ReturnPointForIndex:0];
        
    }
    else{
        
        randomBox.center = [specialViewtoAccept ReturnPointForIndex:(indexCount -1)];
    }
    [specialViewtoAccept addSubview:randomBox];
    [specialViewtoAccept sendSubviewToBack:randomBox];
}
#pragma mark - Gestures For View
-(void)AddSwipeGestureToView{
    
    
    
    UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipeOnViewController:)];
    [rightSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rightSwipeRecognizer];
    
    UISwipeGestureRecognizer *leftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipeOnViewController:)];
    [leftSwipeRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:leftSwipeRecognizer];
    
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
    [panGesture addTarget:self action:@selector(handlePan:)];
    [self.centerView addGestureRecognizer:panGesture];
    [leftSwipeRecognizer requireGestureRecognizerToFail:panGesture];
    [rightSwipeRecognizer requireGestureRecognizerToFail:panGesture];
    
    
    
}


-(void)handleRightSwipeOnViewController:(UISwipeGestureRecognizer*)recognizer{
    NSUInteger tag;
    CGPoint pointOfTouch = [recognizer locationInView:self.view];
    NSUInteger index = pointOfTouch.y /(self.view.frame.size.height/2);
    if (index) tag = 1;
    else tag = 0;
    [self SpecialViewWasSwipedWithTag:tag];
    
}
-(void)handleLeftSwipeOnViewController:(UISwipeGestureRecognizer*)recognizer{
    NSUInteger tag;
    CGPoint pointOfTouch = [recognizer locationInView:self.view];
    NSUInteger index = pointOfTouch.y /(self.view.frame.size.height/2);
    if (index) tag = 3;
    else tag = 2;
    [self SpecialViewWasSwipedWithTag:tag];
    
}


-(void)handlePan:(UIPanGestureRecognizer*)recognizer{
    
    
    CGPoint  point1 = [recognizer locationInView:recognizer.view];
    CGPoint changeInPoint1 = [recognizer translationInView:recognizer.view];
    CGPoint  point2 = CGPointMake(point1.x + changeInPoint1.x, point1.y +changeInPoint1.y);
    
    CGFloat angleChange = angleBetweenPointsWithCenter(point2, point1, CGPointMake(self.centerView.frame.size.width/2, self.centerView.frame.size.height/2));
    
    
    [self RotateCenterViewsByAngle:angleChange];
    
    if (recognizer.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.2 animations:^{
            [self snapCenterViewsToClosestIndex];
        }];}
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];
    
    
    
}

-(void)RotateCenterViewsByAngle:(CGFloat)angle{
    for (UIView *viewInCenterView in self.centerView.subviews){
        CGPoint rotatedCenter =  rotatePointAroundCenterByAngle(angle, viewInCenterView.center, CGPointMake(self.centerView.frame.size.width/2, self.centerView.frame.size.height/2));
        
        
        
        viewInCenterView.center = rotatedCenter;
        
        
        
    }
}
-(void)snapCenterViewsToClosestIndex{
    NSMutableArray *views = [[NSMutableArray alloc] init];
    NSMutableArray *centers = [[NSMutableArray alloc] init];
    for (NSUInteger i=0; i<4; i++){
        CGPoint centerViewIndex = [self.centerView ReturnPointForIndex:i];
        CGFloat minDist =  distanceBetweenPoints(CGPointZero, CGPointMake(self.centerView.frame.size.width, self.centerView.frame.size.height));
        UIView *viewAtIndex;
        
        for (UIView *subViews in self.centerView.subviews){
            CGPoint subviewCenter = subViews.center;
            CGFloat DBPoints = distanceBetweenPoints(centerViewIndex, subviewCenter);
            if (DBPoints<minDist) {
                viewAtIndex = subViews;
                minDist = DBPoints;
            }
            
        }
        [views addObject:viewAtIndex];
        [centers addObject:[NSValue valueWithCGPoint:centerViewIndex]];
    }
    for (NSUInteger j=0; j<views.count; j++){
        UIView *view = (UIView*)[views objectAtIndex:j];
        CGPoint center = [[centers objectAtIndex:j] CGPointValue];
        view.center = center;
    }
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake)
    {
        NSLog(@"called");
        [self Restart];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}


- (IBAction)mainMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
