//
//  ELCtrlTransitioningDelegate.m
//  EMLive
//
//  Created by roronoa on 16/9/19.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "ELObjectTransitioningDelegate.h"

#pragma mark - 通用弹窗
/**  **/
@implementation ELCommonBoxTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELCommonBoxPresentAnimator new];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELCommonBoxDismissAnimator new];
    return _dimissTransitioning;
}

@end


/**  **/
@implementation ELCommonBoxPresentAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.alpha = 0.3;
    [containerView addSubview:toView];
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(toView.y);
        make.centerX.equalTo(containerView);
        make.width.mas_equalTo(toView.width);
        make.height.mas_equalTo(toView.height);
    }];
    [containerView layoutIfNeeded];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end


/** **/
@implementation ELCommonBoxDismissAnimator

@end

#pragma mark - 对话框
/**  **/
@implementation ELMsgTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELMsgPresentAnimator new];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELMsgDismissAnimator new];
    return _dimissTransitioning;
}

@end


/**  **/
@implementation ELMsgPresentAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    [super animateTransition:transitionContext];
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(containerView);
        make.height.mas_equalTo(containerView.height / 2);
        make.bottom.equalTo(containerView).offset(containerView.height / 2);
    }];
    [containerView layoutIfNeeded];
    [toView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(containerView);
    }];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

/** **/
@implementation ELMsgDismissAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //不要继承
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [fromVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(containerView).offset(containerView.height / 2);
    }];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromVC.el_transitioningDelegate = nil;
    }];
    
    //告诉控制器可以自动弹出红包了
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ELPresentedCtrlDismissNotification" object:nil];
    
}

@end

#pragma mark -
#pragma mark - 分享
/** **/
@implementation ELShareTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELSharePresentAnimator new];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELShareDismissAnimator new];
    return _dimissTransitioning;
}

@end

@implementation ELSharePresentAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(containerView);
        make.height.mas_equalTo(184);
        make.bottom.equalTo(containerView).offset(184);
    }];
    [containerView layoutIfNeeded];
    [toView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(containerView);
    }];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

@implementation ELShareDismissAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //不要继承
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [fromVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(containerView).offset(184);
    }];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromVC.el_transitioningDelegate = nil;
    }];
    
    //告诉控制器可以自动弹出红包了
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ELPresentedCtrlDismissNotification" object:nil];
}

@end


#pragma mark - 运营位
/**  **/
@implementation ELDBOTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELDBOPresentAnimator new];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELDBODismissAnimator new];
    return _dimissTransitioning;
}

@end


/**  **/
@implementation ELDBOPresentAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
    
    UIView *containerView = transitionContext.containerView;

    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.alpha = 0.3;
    [containerView addSubview:toView];
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(containerView);
        make.width.equalTo(containerView.mas_width).multipliedBy(0.85);
        make.height.equalTo(containerView.mas_height).multipliedBy(0.85);
    }];
    [containerView layoutIfNeeded];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end


/** **/
@implementation ELDBODismissAnimator

@end

#pragma mark -
#pragma mark - 红包
/**  **/
@implementation ELRedTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELRedPresentAnimator new];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELRedDismissAnimator new];
    return _dimissTransitioning;
}

@end


/**  **/
@implementation ELRedPresentAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
    UIView *containerView = transitionContext.containerView;
    CGFloat width = containerView.width;
    CGFloat height = containerView.height;
    CGFloat tMargin = (height - 256 - 370 - 20) / 2;        //键盘和自己的高度
    tMargin = MAX(tMargin, 20.0f);
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.alpha = 0.3;
    toView.frame = CGRectMake((width - 280) / 2, tMargin, 280, 370);
    [toView sb_centerOfView:containerView];
    
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end


/** **/
@implementation ELRedDismissAnimator

@end

#pragma mark -
#pragma mark - 红包
/**  **/
@implementation ELRed2TransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELRed2PresentAnimator new];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELRed2DismissAnimator new];
    return _dimissTransitioning;
}

@end


/**  **/
@implementation ELRed2PresentAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.alpha = 0.3;
    [containerView addSubview:toView];
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(containerView);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(305);
    }];
    [containerView layoutIfNeeded];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end


/** **/
@implementation ELRed2DismissAnimator

@end


#pragma mark -
#pragma mark - 个人卡片
/**  **/
@implementation ELUserTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELUserPresentAnimator new];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELUserDismissAnimator new];
    return _dimissTransitioning;
}

@end


/**  **/
@implementation ELUserPresentAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.alpha = 0.3;
    [containerView addSubview:toView];
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(containerView);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(305);
    }];
    [containerView layoutIfNeeded];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end


/** **/
@implementation ELUserDismissAnimator

@end

#pragma mark - 截图
/**  **/
@implementation ELShotTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELShotPresentAnimator new];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELShottDismissAnimator new];
    return _dimissTransitioning;
}

@end

/**  **/
@implementation ELShotPresentAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.alpha = 0.3;
    [containerView addSubview:toView];
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(containerView);
        make.width.equalTo(containerView.mas_width);
        make.height.equalTo(containerView.mas_height);
    }];
    [containerView layoutIfNeeded];
    
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(containerView);
        make.width.equalTo(containerView.mas_width).multipliedBy(0.85);
        make.height.equalTo(containerView.mas_height).multipliedBy(0.85);
    }];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView layoutIfNeeded];
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end


/** **/
@implementation ELShottDismissAnimator

@end

#pragma mark - 美颜
/**  **/
@implementation ELBeautyTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELBeautyPresentAnimator new];
    [(ELBeautyPresentAnimator *)_presentedTransitioning setHideMask:YES];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELBeautyDismissAnimator new];
    return _dimissTransitioning;
}

@end

/** **/
@implementation ELBeautyPresentAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.alpha = 0.3;
    [containerView addSubview:toView];
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(toView.y);
        make.centerX.equalTo(containerView);
        make.width.mas_equalTo(toView.width);
        make.height.mas_equalTo(toView.height);
    }];
    [containerView layoutIfNeeded];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

/** **/
@implementation ELBeautyDismissAnimator

@end

#pragma mark - 音效
/**  **/
@implementation ELSoundEffectTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELSoundEffectPresentAnimator new];
    [(ELSoundEffectPresentAnimator *)_presentedTransitioning setHideMask:YES];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELSoundEffectDismissAnimator new];
    return _dimissTransitioning;
}

@end


/** **/
@implementation ELSoundEffectPresentAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.alpha = 0.3;
    [containerView addSubview:toView];
    [toView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(toView.y);
        make.centerX.equalTo(containerView);
        make.width.mas_equalTo(toView.width);
        make.height.mas_equalTo(toView.height);
    }];
    [containerView layoutIfNeeded];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end


/** **/
@implementation ELSoundEffectDismissAnimator

@end


#pragma mark - 
#define kGiftViewHeight (194+37+10+45)
#define kGiftViewHeightLandscapeModel (97+37+10+45)
/**  **/
@implementation ELFromBottomTransitioningDelegate : ELCtrlTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELFromBottomPresentAnimator new];
    [(ELFromBottomPresentAnimator *)_presentedTransitioning setHideMask:YES];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELFromBottomDismissAnimator new];
    return _dimissTransitioning;
}

@end

/**  **/
@implementation ELFromBottomTransitioning2Delegate : ELCtrlTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _presentedTransitioning = [ELFromBottomPresentAnimator new];
    return _presentedTransitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _dimissTransitioning = [ELFromBottomDismissAnimator new];
    return _dimissTransitioning;
}

@end


/**  **/
@implementation ELFromBottomPresentAnimator : ELCtrlPresentAnimator
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
    
    UIView *containerView = transitionContext.containerView;
    
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    toView.alpha = 1;
    [containerView addSubview:toView];
    [toView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(containerView);
        make.top.equalTo(containerView.mas_bottom);
        make.height.mas_equalTo(ELLandscape ? kGiftViewHeightLandscapeModel : kGiftViewHeight);
    }];
    [containerView layoutIfNeeded];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1;
        [containerView el_removeConstraintsWithFirstItem:toView firstAttribute:(NSLayoutAttributeTop)];
        [toView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(containerView);
        }];
        [containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end


/** **/
@implementation ELFromBottomDismissAnimator : ELCtrlDismissAnimator
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //不要继承
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [containerView el_removeConstraintsWithFirstItem:fromVC.view firstAttribute:(NSLayoutAttributeBottom)];
        [fromVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(containerView.mas_bottom);
        }];
        [containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromVC.el_transitioningDelegate = nil;
        //告诉控制器可以自动弹出红包了
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ELPresentedCtrlDismissNotification" object:nil];
    }];
}

@end
