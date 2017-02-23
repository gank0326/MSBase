//
//  ELCtrlTransitioningDelegate.h
//  EMLive
//
//  Created by roronoa on 16/9/19.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "ELCtrlTransitioningDelegate.h"         //界面切换动画


#pragma mark - 通用弹窗
/** 
 在各自的Controller的viewDidLoad里设置窗口位置大小
 self.view.y = (self.view.height - 180)/2;
 self.view.width = 260;
 self.view.height = 180;
 **/
@interface ELCommonBoxTransitioningDelegate : ELCtrlTransitioningDelegate

@end


/**  **/
@interface ELCommonBoxPresentAnimator : ELCtrlPresentAnimator

@end


/** **/
@interface ELCommonBoxDismissAnimator : ELCtrlDismissAnimator

@end


#pragma mark -
#pragma mark - 对话框
/** **/
@interface ELMsgTransitioningDelegate : ELCtrlTransitioningDelegate

@end


@interface ELMsgPresentAnimator : ELCtrlPresentAnimator

@end


@interface ELMsgDismissAnimator : ELCtrlDismissAnimator

@end


#pragma mark -
#pragma mark - 分享
/** **/
@interface ELShareTransitioningDelegate : ELCtrlTransitioningDelegate

@end


@interface ELSharePresentAnimator : ELCtrlPresentAnimator

@end


@interface ELShareDismissAnimator : ELCtrlDismissAnimator
@end


#pragma mark -
#pragma mark - 运营位
/**  **/
@interface ELDBOTransitioningDelegate : ELCtrlTransitioningDelegate

@end

/**  **/
@interface ELDBOPresentAnimator : ELCtrlPresentAnimator

@end


/** **/
@interface ELDBODismissAnimator : ELCtrlDismissAnimator

@end


#pragma mark -
#pragma mark - 红包 （发） 带键盘
/**  **/
@interface ELRedTransitioningDelegate : ELCtrlTransitioningDelegate

@end


/**  **/
@interface ELRedPresentAnimator : ELCtrlPresentAnimator

@end


/** **/
@interface ELRedDismissAnimator : ELCtrlDismissAnimator

@end


#pragma mark -
#pragma mark - 红包 （收）列表
/**  **/
@interface ELRed2TransitioningDelegate : ELCtrlTransitioningDelegate

@end


/**  **/
@interface ELRed2PresentAnimator : ELCtrlPresentAnimator

@end


/** **/
@interface ELRed2DismissAnimator : ELCtrlDismissAnimator

@end


#pragma mark -
#pragma mark - 个人卡片
/**  **/
@interface ELUserTransitioningDelegate : ELCtrlTransitioningDelegate

@end


/**  **/
@interface ELUserPresentAnimator : ELCtrlPresentAnimator

@end


/** **/
@interface ELUserDismissAnimator : ELCtrlDismissAnimator

@end


#pragma mark - 截图
/**  **/
@interface ELShotTransitioningDelegate : ELCtrlTransitioningDelegate

@end

/**  **/
@interface ELShotPresentAnimator : ELCtrlPresentAnimator

@end


/** **/
@interface ELShottDismissAnimator : ELCtrlDismissAnimator

@end


#pragma mark - 美颜
/**  **/
@interface ELBeautyTransitioningDelegate : ELCtrlTransitioningDelegate

@end


/**  **/
@interface ELBeautyPresentAnimator : ELCtrlPresentAnimator

@end


/** **/
@interface ELBeautyDismissAnimator : ELCtrlDismissAnimator

@end


#pragma mark - 音效
/**  **/
@interface ELSoundEffectTransitioningDelegate : ELCtrlTransitioningDelegate

@end


/**  **/
@interface ELSoundEffectPresentAnimator : ELCtrlPresentAnimator

@end


/** **/
@interface ELSoundEffectDismissAnimator : ELCtrlDismissAnimator

@end


#pragma mark - 从下面弹到全屏
/**  **/
@interface ELFromBottomTransitioningDelegate : ELCtrlTransitioningDelegate

@end

/** 有蒙版 **/
@interface ELFromBottomTransitioning2Delegate : ELCtrlTransitioningDelegate

@end


/**  **/
@interface ELFromBottomPresentAnimator : ELCtrlPresentAnimator

@end


/** **/
@interface ELFromBottomDismissAnimator : ELCtrlDismissAnimator

@end

