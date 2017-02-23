//
//  UIViewController+ELPresent.h
//  EMLive
//
//  Created by menglingchao on 16/9/18.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (EL_Transition)
@property (nonatomic, strong, nullable) id <UIViewControllerTransitioningDelegate> el_transitioningDelegate;
@end

@interface UIViewController (EL_Present)

/** 通用弹窗 **/
- (void)el_presentCommonBox:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;

/** 弹聊天 **/
- (void)el_presentMsg:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;

/** 弹分享 **/
- (void)el_presentShare:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;

/** 弹H5 **/
- (void)el_presentH5:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;

/** 弹发红包 **/
- (void)el_presentRed:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;

/** 弹收红包 **/
- (void)el_presentRed2:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;

/** 弹用户信息 **/
- (void)el_presentUser:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;

/** 弹截图 **/
- (void)el_presentShot:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;

/** 弹美颜 **/
- (void)el_presentBeauty:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;

/** 弹音效调节 **/
- (void)el_presentSoundEffect:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;

/** 从下面弹到全屏 **/
- (void)el_presentFromBottom:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;

/** 从下面弹到全屏 **/
- (void)el_presentFromBottom2:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;

/*! 全屏弹出，溶解效果 */
- (void)el_presentFullscreenCtrl:(nullable UIViewController *)ctrl completion:(void (^ __nullable)(void))completion;
@end
