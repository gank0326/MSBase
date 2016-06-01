//
//  UIViewController+Popup.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+Popup.h"

#define ANIMATION_TIME 0.25f
#define STATUS_BAR_SIZE 22

NSString const *PopupKey = @"Popupkey";
NSString const *BlurViewKey = @"FadeViewKey";
NSString const *UseBlurForPopup = @"UseBlurForPopup";
NSString const *PopupViewOffset = @"PopupViewOffset";

@implementation UIViewController (Popup)
@dynamic popupViewController, useBlurForPopup, popupViewOffset;

#pragma mark - blur view methods

- (UIImage *)getScreenImage {
    // frame without status bar
    CGRect frame;
    if (UIDeviceOrientationIsPortrait((UIDeviceOrientation) [UIApplication sharedApplication].statusBarOrientation) || NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)
    {
        frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    else
    {
        frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    // begin image context
    UIGraphicsBeginImageContext(frame.size);
    // get current context
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    // draw current view
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    // clip context to frame
    CGContextClipToRect(currentContext, frame);
    // get resulting cropped screenshot
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    // end image context
    UIGraphicsEndImageContext();
    return screenshot;
}

- (UIImage *)getBlurredImage:(UIImage *)imageToBlur
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        return  [imageToBlur applyBlurWithRadius:10.0f tintColor:[UIColor clearColor] saturationDeltaFactor:1.0 maskImage:nil];
    }
    return imageToBlur;
}

- (void)addBlurView
{
    UIImageView *blurView = [UIImageView new];
    [blurView setUserInteractionEnabled:YES];
    if (UIDeviceOrientationIsPortrait((UIDeviceOrientation) [UIApplication sharedApplication].statusBarOrientation) || NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        blurView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    } else {
        blurView.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
    }
    blurView.alpha = 0.0f;
    blurView.image = [self getBlurredImage:[self getScreenImage]];
    [self.view addSubview:blurView];
    [self.view bringSubviewToFront:self.popupViewController.view];
    objc_setAssociatedObject(self, &BlurViewKey, blurView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - present/dismiss
- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (self.popupViewController == nil)
    {
        // initial setup
        self.popupViewController = viewControllerToPresent;
        self.popupViewController.view.autoresizesSubviews = NO;
        //        self.popupViewController.view.autoresizingMask = UIViewAutoresizingNone;
        self.popupViewController.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        [self addChildViewController:viewControllerToPresent];
        
        CGRect finalFrame = [self getPopupFrameForViewController:viewControllerToPresent];
        
        
        if (self.useBlurForPopup) {
            [self addBlurView];
        } else {
            UIView *fadeView = [UIImageView new];
            [fadeView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tapGestureRecognizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundImageViewTapAction:)];
            [fadeView addGestureRecognizer:tapGestureRecognizer];
            
            if (UIDeviceOrientationIsPortrait((UIDeviceOrientation) [UIApplication sharedApplication].statusBarOrientation) || NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
                fadeView.frame = [UIScreen mainScreen].bounds;
            } else {
                fadeView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
            }
            fadeView.backgroundColor = [UIColor blackColor];
            fadeView.alpha = 0.0f;
            [self.view addSubview:fadeView];
            objc_setAssociatedObject(self, &BlurViewKey, fadeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        UIView *blurView = objc_getAssociatedObject(self, &BlurViewKey);
        
        [viewControllerToPresent beginAppearanceTransition:YES animated:flag];
        
        // setup
        if (flag)
        { // animate
            CGRect initialFrame = CGRectMake(finalFrame.origin.x, [UIScreen mainScreen].bounds.size.height + viewControllerToPresent.view.frame.size.height/2, finalFrame.size.width, finalFrame.size.height);
            CGFloat initialAlpha = 1.0;
            CGFloat finalAlpha = 1.0;
            if (self.modalTransitionStyle == UIModalTransitionStyleCrossDissolve)
            {
                initialFrame = finalFrame;
                initialAlpha = 0.0;
            }
            viewControllerToPresent.view.frame = initialFrame;
            viewControllerToPresent.view.alpha = initialAlpha;
            [self.view addSubview:viewControllerToPresent.view];
            [UIView animateWithDuration:ANIMATION_TIME delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
             {
                 viewControllerToPresent.view.frame = finalFrame;
                 viewControllerToPresent.view.alpha = finalAlpha;
                 blurView.alpha = self.useBlurForPopup ? 1.0f : 0.4f;
             } completion:^(BOOL finished)
             {
                 [self.popupViewController didMoveToParentViewController:self];
                 [self.popupViewController endAppearanceTransition];
                 [(NSInvocation *) completion invoke];
             }];
        }
        else
        { // don't animate
            viewControllerToPresent.view.frame = finalFrame;
            [self.view addSubview:viewControllerToPresent.view];
            [self.popupViewController didMoveToParentViewController:self];
            [self.popupViewController endAppearanceTransition];
            [(NSInvocation *) completion invoke];
        }
        // if screen orientation changed
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenOrientationChanged) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
}

- (void)dismissPopupViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    UIView *blurView = objc_getAssociatedObject(self, &BlurViewKey);
    [self.popupViewController willMoveToParentViewController:nil];
    
    [self.popupViewController beginAppearanceTransition:NO animated:flag];
    if (flag)
    { // animate
        CGRect initialFrame = self.popupViewController.view.frame;
        CGRect finalFrame = CGRectMake(initialFrame.origin.x, [UIScreen mainScreen].bounds.size.height + initialFrame.size.height/2, initialFrame.size.width, initialFrame.size.height);
        CGFloat finalAlpha = 1.0;
        if (self.modalTransitionStyle == UIModalTransitionStyleCrossDissolve) {
            finalFrame = initialFrame;
            finalAlpha = 0.0;
        }
        [UIView animateWithDuration:ANIMATION_TIME delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
         {
             self.popupViewController.view.frame = finalFrame;
             self.popupViewController.view.alpha = finalAlpha;
             // uncomment the line below to have slight rotation during the dismissal
             //self.popupViewController.view.transform = CGAffineTransformMakeRotation(M_PI/6);
             blurView.alpha = 0.0f;
         } completion:^(BOOL finished)
         {
             [self.popupViewController removeFromParentViewController];
             [self.popupViewController endAppearanceTransition];
             [self.popupViewController.view removeFromSuperview];
             [blurView removeFromSuperview];
             self.popupViewController = nil;
             [(NSInvocation *) completion invoke];
         }];
    }
    else
    { // don't animate
        [self.popupViewController removeFromParentViewController];
        [self.popupViewController endAppearanceTransition];
        [self.popupViewController.view removeFromSuperview];
        [blurView removeFromSuperview];
        self.popupViewController = nil;
        blurView = nil;
        [(NSInvocation *) completion invoke];
    }
    // remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

#pragma mark - handling screen orientation change

- (CGRect)getPopupFrameForViewController:(UIViewController *)viewController
{
    CGRect frame = viewController.view.frame;
    CGFloat x;
    CGFloat y;
    if (UIDeviceOrientationIsPortrait((UIDeviceOrientation) [UIApplication sharedApplication].statusBarOrientation) || NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)
    {
        x = ([UIScreen mainScreen].bounds.size.width - frame.size.width)/2;
        y = ([UIScreen mainScreen].bounds.size.height - frame.size.height)/2;
    }
    else
    {
        x = ([UIScreen mainScreen].bounds.size.height - frame.size.width)/2;
        y = ([UIScreen mainScreen].bounds.size.width - frame.size.height)/2;
    }
    return CGRectMake(x + viewController.popupViewOffset.x, y + viewController.popupViewOffset.y, frame.size.width, frame.size.height);
}

- (void)screenOrientationChanged
{
    // make blur view go away so that we can re-blur the original back
    UIView *blurView = objc_getAssociatedObject(self, &BlurViewKey);
    [UIView animateWithDuration:ANIMATION_TIME animations:^{
        self.popupViewController.view.frame = [self getPopupFrameForViewController:self.popupViewController];
        if (UIDeviceOrientationIsPortrait((UIDeviceOrientation) [UIApplication sharedApplication].statusBarOrientation) || NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
            blurView.frame = [UIScreen mainScreen].bounds;
        } else {
            blurView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
        }
        if (self.useBlurForPopup)
        {
            [UIView animateWithDuration:1.0f animations:^
             {
                 // for delay
             } completion:^(BOOL finished)
             {
                 [blurView removeFromSuperview];
                 // popup view alpha to 0 so its not in the blur image
                 self.popupViewController.view.alpha = 0.0f;
                 [self addBlurView];
                 self.popupViewController.view.alpha = 1.0f;
                 // display blurView again
                 UIView *blurView = objc_getAssociatedObject(self, &BlurViewKey);
                 blurView.alpha = 1.0f;
             }];
        }
    }];
}

#pragma mark - popupViewController getter/setter

- (void)setPopupViewController:(UIViewController *)popupViewController {
    objc_setAssociatedObject(self, &PopupKey, popupViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)popupViewController {
    return objc_getAssociatedObject(self, &PopupKey);
    
}

- (void)setUseBlurForPopup:(BOOL)useBlurForPopup {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0 && useBlurForPopup) {
        NSLog(@"ERROR: Blur unavailable prior to iOS 7");
        objc_setAssociatedObject(self, &UseBlurForPopup, @NO, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else {
        objc_setAssociatedObject(self, &UseBlurForPopup, @(useBlurForPopup), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (BOOL)useBlurForPopup {
    NSNumber *result = objc_getAssociatedObject(self, &UseBlurForPopup);
    return [result boolValue];
    
}

- (void)setPopupViewOffset:(CGPoint)popupViewOffset {
    objc_setAssociatedObject(self, &PopupViewOffset, [NSValue valueWithCGPoint:popupViewOffset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)popupViewOffset {
    NSValue *offset = objc_getAssociatedObject(self, &PopupViewOffset);
    return [offset CGPointValue];
}

-(void)backgroundImageViewTapAction:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self dismissPopupViewControllerAnimated:YES completion:^
     {
         
     }];
}
@end
