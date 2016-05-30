//
//  MSLaunchHelper.h
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSLaunchHelper : NSObject

SB_ARC_SINGLETON_DEFINE(MSLaunchHelper)

@property (strong, nonatomic) UIWindow *window;         //主window

/** 注册功能 */
+ (void)install:(UIWindow *)window;

//加载主界面
+ (void)launchMainCtrl:(DataItemDetail *)userInfo;

//从外部应用进入
+ (BOOL)openURL:(NSURL *)url;

/** 启动配制 */
+ (DataItemDetail *)launchInfo;

@end
