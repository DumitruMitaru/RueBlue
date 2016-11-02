//
//  UIView+Glow.m
//
//  Created by Jon Manning on 29/05/12.
//  Copyright (c) 2012 Secret Lab. All rights reserved.
//

#import "UIView+Glow.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

// Used to identify the associating glowing view
static char* GLOWVIEW_KEY = "GLOWVIEW";


@implementation UIView (Glow)

// Get the glowing view attached to this one.
- (UIView*) glowView {
    return objc_getAssociatedObject(self, GLOWVIEW_KEY);
}

// Attach a view to this one, which we'll use as the glowing view.
- (void) setGlowView:(UIView*)glowView {
    objc_setAssociatedObject(self, GLOWVIEW_KEY, glowView, OBJC_ASSOCIATION_RETAIN);
}

- (void)startGlowingWithColor:(UIColor *)color intensity:(CGFloat)intensity {
    [self startGlowingWithColor:color fromIntensity:0.1 toIntensity:intensity repeat:YES];
}

- (void) startGlowingWithColor:(UIColor*)color fromIntensity:(CGFloat)fromIntensity toIntensity:(CGFloat)toIntensity repeat:(BOOL)repeat {
    UIView *glowView = [self glowView];
    // If we're already glowing, don't bother
    if (!glowView){
        
    
    // The glow image is taken from the current view's appearance.
    // As a side effect, if the view's content, size or shape changes,
    // the glow won't update.
    UIImage* image;
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale); {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        
        [color setFill];
        
        [path fillWithBlendMode:kCGBlendModeSourceAtop alpha:1.0];
        
        
        image = UIGraphicsGetImageFromCurrentImageContext();
    } UIGraphicsEndImageContext();
    
    // Make the glowing view itself, and position it at the same
    // point as ourself. Overlay it over ourself.
    glowView = [[UIImageView alloc] initWithImage:image];
    glowView.center = self.center;
    
    
    // We don't want to show the image, but rather a shadow created by
    // Core Animation. By setting the shadow to white and the shadow radius to
    // something large, we get a pleasing glow.
    glowView.alpha = 0;
    glowView.layer.shadowColor = color.CGColor;
    glowView.layer.shadowOffset = CGSizeZero;
    glowView.layer.shadowRadius = 10;
    glowView.layer.shadowOpacity = 1.0;
    }
    [self.superview insertSubview:glowView aboveSubview:self];
    // Create an animation that slowly fades the glow view in and out forever.
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(fromIntensity);
    animation.toValue = @(toIntensity);
    animation.repeatCount = repeat ? HUGE_VAL : 0;
    animation.duration = 1.0;
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [glowView.layer addAnimation:animation forKey:@"pulse"];
    
    // Finally, keep a reference to this around so it can be removed later
    [self setGlowView:glowView];
}

- (void) glowOnceAtLocation:(CGPoint)point inView:(UIView*)view {
    [self startGlowingWithColor:[UIColor whiteColor] fromIntensity:0 toIntensity:0.6 repeat:NO];
    
    [self glowView].center = point;
    [view addSubview:[self glowView]];
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self stopGlowing];
    });
}

- (void)glowOnce {
    [self startGlowing];
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self stopGlowing];
    });
    
}

// Create a pulsing, glowing view based on this one.
- (void) startGlowing {
    [self startGlowingWithColor:[UIColor whiteColor] intensity:0.6];
}

// Stop glowing by removing the glowing view from the superview
// and removing the association between it and this object.
- (void) stopGlowing {
    [[self glowView] removeFromSuperview];
    if (self.tag)[self setGlowView:nil];
}
- (void)startWiggling {
    
    CGFloat duration = 0.5;
    CAAnimation *rotationAnimation = [self wiggleRotationAnimation:duration];
    [self.layer addAnimation:rotationAnimation forKey:@"wiggleRotation"];
    
    /* CAAnimation *translationYAnimation = [self wiggleTranslationYAnimation:duration];
     [self.layer addAnimation:translationYAnimation forKey:@"wiggleTranslationY"];*/
    
}
- (CAAnimation *)wiggleRotationAnimation:(CGFloat)duration {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0],
                   [NSNumber numberWithFloat:6.24],
                   nil];
    anim.duration = duration;
    //anim.autoreverses = YES;
    anim.repeatCount = HUGE_VALF;
    return anim;
}
-(CAAnimation*)colorChangeAnimation:(CGFloat)duration{
    CAKeyframeAnimation *colorAnim = [CAKeyframeAnimation animationWithKeyPath:@"shadowColor"];
    colorAnim.values = [NSArray arrayWithObjects:(id)[UIColor orangeColor].CGColor, (id)[UIColor greenColor].CGColor, (id)[UIColor yellowColor].CGColor,(id)[UIColor magentaColor].CGColor, (id)[UIColor redColor].CGColor, nil];
    colorAnim.duration = duration;
    colorAnim.repeatCount = HUGE_VAL;
    return colorAnim;
    
}
-(void)startColoring{
    CGFloat duration = 0.8;
    CAAnimation *colorAnim = [self colorChangeAnimation:duration];
    [self.layer addAnimation:colorAnim forKey:@"colorAnimation"];
}
- (void)stopWiggling {
    
    [self.layer removeAnimationForKey:@"wiggleRotation"];
    [self.layer removeAnimationForKey:@"wiggleTranslationY"];
    
    
}
- (CAAnimation *)wiggleTranslationYAnimation:(CGFloat)duration {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    anim.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-1.0f],
                   [NSNumber numberWithFloat:1.0f],
                   nil];
    anim.duration = duration;
    //anim.autoreverses = YES;
    anim.repeatCount = HUGE_VALF;
    anim.additive = YES;
    return anim;
}
-(void)setGlowViewToCurrentStateWithColor:(UIColor*)color{
    UIView* glowView = [self glowView];
    if (!glowView){
        
        
        // The glow image is taken from the current view's appearance.
        // As a side effect, if the view's content, size or shape changes,
        // the glow won't update.
        UIImage* image;
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale); {
            [self.layer renderInContext:UIGraphicsGetCurrentContext()];
            
            UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
            
            [color setFill];
            
            [path fillWithBlendMode:kCGBlendModeSourceAtop alpha:1.0];
            
            
            image = UIGraphicsGetImageFromCurrentImageContext();
        } UIGraphicsEndImageContext();
        
        // Make the glowing view itself, and position it at the same
        // point as ourself. Overlay it over ourself.
        glowView = [[UIImageView alloc] initWithImage:image];
        glowView.center = self.center;
        
        
        // We don't want to show the image, but rather a shadow created by
        // Core Animation. By setting the shadow to white and the shadow radius to
        // something large, we get a pleasing glow.
        glowView.alpha = 0;
        glowView.layer.shadowColor = color.CGColor;
        glowView.layer.shadowOffset = CGSizeZero;
        glowView.layer.shadowRadius = 10;
        glowView.layer.shadowOpacity = 1.0;
        [self setGlowView:glowView];
    }
    self.tag = 0;
}
-(void)stopColoringWithFinalColor:(UIColor*)lastColor{
    [self.layer removeAnimationForKey:@"colorAnimation"];
    self.layer.shadowColor = lastColor.CGColor;
}
@end