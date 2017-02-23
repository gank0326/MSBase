//
//  UIViewController+ELPresent.m
//  EMLive
//
//  Created by menglingchao on 16/9/18.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "UIViewController+ELPresent.h"
#import <objc/runtime.h>
#import "ELObjectTransitioningDelegate.h"

NSString const *EL_TransitioningDelegate = @"EL_TransitioningDelegate";

@implementation UIViewController (EL_Transition)
@dynamic el_transitioningDelegate;
- (void)setEl_transitioningDelegate:(id<UIViewControllerTransitioningDelegate>)el_transitioningDelegate {
    objc_setAssociatedObject(self, &EL_TransitioningDelegate, el_transitioningDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UIViewControllerTransitioningDelegate>)el_transitioningDelegate {
    return objc_getAssociatedObject(self, &EL_TransitioningDelegate);
}

@end

@implementation UIViewController (EL_Present)

/** 通用弹窗 **/
- (void)el_presentCommonBox:(UIViewController *)ctrl completion:(void (^)(void))completion {
    ELCommonBoxTransitioningDelegate *delegate = [ELCommonBoxTransitioningDelegate new];
    [self el_presentCtrl:ctrl delegate:delegate completion:completion];
}

/**  **/
- (void)el_presentMsg:(UIViewController *)ctrl completion:(void (^)(void))completion {
    ELMsgTransitioningDelegate *delegate = [ELMsgTransitioningDelegate new];
    [self el_presentCtrl:ctrl delegate:delegate completion:completion];
}

/** 弹分享 **/
- (void)el_presentShare:(UIViewController *)ctrl completion:(void (^)(void))completion {
    ELShareTransitioningDelegate *delegate = [ELShareTransitioningDelegate new];
    [self el_presentCtrl:ctrl delegate:delegate completion:completion];
}

/**  **/
- (void)el_presentH5:(UIViewController *)ctrl completion:(void (^)(void))completion {
    ctrl.view.clipsToBounds = YES;
    ctrl.view.layer.cornerRadius = 5;
    ELDBOTransitioningDelegate *delegate = [ELDBOTransitioningDelegate new];
    [self el_presentCtrl:ctrl delegate:delegate completion:completion];
}

/** 弹红包 **/
- (void)el_presentRed:(UIViewController *)ctrl completion:(void (^)(void))completion {
    ELRedTransitioningDelegate *delegate = [ELRedTransitioningDelegate new];
    [self el_presentCtrl:ctrl delegate:delegate completion:completion];
}

/** 弹收红包 **/
- (void)el_presentRed2:(UIViewController *)ctrl completion:(void (^)(void))completion {
    ELRed2TransitioningDelegate *delegate = [ELRed2TransitioningDelegate new];
    [self el_presentCtrl:ctrl delegate:delegate completion:completion];
}
/** 弹用户信息 **/
- (void)el_presentUser:(UIViewController *)ctrl completion:(void (^)(void))completion {
    ELUserTransitioningDelegate *delegate = [ELUserTransitioningDelegate new];
    [self el_presentCtrl:ctrl delegate:delegate completion:completion];
}

/** 弹截图 **/
- (void)el_presentShot:(UIViewController *)ctrl completion:(void (^ __nullable)(void))completion {
    ELShotTransitioningDelegate *delegate = [ELShotTransitioningDelegate new];
    [self el_presentCtrl:ctrl delegate:delegate completion:completion];
}

/** 弹美颜 **/
- (void)el_presentBeauty:(UIViewController *)ctrl completion:(void (^ __nullable)(void))completion {
    ELBeautyTransitioningDelegate *delegate = [ELBeautyTransitioningDelegate new];
    [self el_presentCtrl:ctrl delegate:delegate completion:completion];
}

/** 弹音效调节 **/
- (void)el_presentSoundEffect:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion {
    ELSoundEffectTransitioningDelegate *delegate = [ELSoundEffectTransitioningDelegate new];
    [self el_presentCtrl:ctrl delegate:delegate completion:completion];
}
/** 从下面弹到全屏 **/
- (void)el_presentFromBottom:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion {
    ELFromBottomTransitioningDelegate *delegate = [ELFromBottomTransitioningDelegate new];
    [self el_presentCtrl:ctrl delegate:delegate completion:completion];
}

/** 从下面弹到全屏 **/
- (void)el_presentFromBottom2:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion {
    ELFromBottomTransitioning2Delegate *delegate = [ELFromBottomTransitioning2Delegate new];
    [self el_presentCtrl:ctrl delegate:delegate completion:completion];
}

/*! 全屏弹出，溶解效果 */
- (void)el_presentFullscreenCtrl:(UIViewController *)ctrl completion:(void (^)(void))completion {
    ctrl.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    ctrl.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:ctrl animated:YES completion:completion];
}


/** 总入口 **/
- (void)el_presentCtrl:(UIViewController *)ctrl delegate:(id<UIViewControllerTransitioningDelegate>)delegate completion:(void (^)(void))completion {
    if (ctrl.el_transitioningDelegate != nil) {
        return;
    }
    
    ctrl.el_transitioningDelegate = delegate;       //这个要用 ctrl 跟着 被推得走
    ctrl.transitioningDelegate = ctrl.el_transitioningDelegate;
    ctrl.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:ctrl animated:YES completion:^{
        if (completion) {
            completion();
        }
    }];
}

@end
