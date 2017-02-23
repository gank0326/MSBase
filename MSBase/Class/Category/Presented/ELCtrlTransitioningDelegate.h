//
//  ELPresentedAtBottomTransitioningDelegate.h
//  EMLive
//
//  Created by menglingchao on 16/9/18.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 弹层在中间 **/
@interface ELCtrlTransitioningDelegate : NSObject<UIViewControllerTransitioningDelegate> {
    id<UIViewControllerAnimatedTransitioning> _presentedTransitioning;
    id<UIViewControllerAnimatedTransitioning> _dimissTransitioning;
}

@end

/** 弹层在中间 **/
@interface ELCtrlPresentAnimator : NSObject<UIViewControllerAnimatedTransitioning> {
    id <UIViewControllerContextTransitioning> _transitionContext;
    UIView *_maskView;
}

@property (nonatomic, assign) BOOL hideMask;

@end

/** 弹层在中间 **/
@interface ELCtrlDismissAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@end
