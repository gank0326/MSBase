//
//  ELPresentedAtBottomTransitioningDelegate.m
//  EMLive
//
//  Created by menglingchao on 16/9/18.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "ELCtrlTransitioningDelegate.h"
#import "UIViewController+ELPresent.h"

@implementation ELCtrlTransitioningDelegate
#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELCtrlPresentAnimator new];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELCtrlDismissAnimator new];
    return _dimissTransitioning;
}

@end


@implementation ELCtrlPresentAnimator

#pragma mark -
- (void)elpresent_dismissCtrl:(id)sender {
    UIViewController *toViewController = [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [toViewController dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark -
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    _transitionContext = transitionContext;
    UIView *containerView = transitionContext.containerView;
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _maskView = [[UIView alloc] init];
    _maskView.backgroundColor = self.hideMask ? RGB_A(0, 0, 0, 0) : RGB_A(0, 0, 0, 0.4);
    if (toViewController.view.tag != 1) {
        [_maskView sb_setTapGesture:self action:@selector(elpresent_dismissCtrl:)];
    }
    [containerView addSubview:_maskView];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(containerView);
    }];
}

@end


@implementation ELCtrlDismissAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0.1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromVC.el_transitioningDelegate = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ELPresentedCtrlDismissNotification" object:nil];
    }];
}

@end




