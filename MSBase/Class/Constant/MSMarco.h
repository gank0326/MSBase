//
//  marco.h
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#ifndef marco_h
#define marco_h

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//常用宏定义
#import "MSDefine.h"

#import "MSViewController.h"
#import "MSNavigationController.h"
//跳转
#import "MSHelper.h"
#import "MSUtil.h"

//网络请求
#import "MSHttpProcess.h"

//友盟
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
//微信分享静态库 头文件
#import "WXApi.h"
#import "WXApiObject.h"
#import "WeiboSDK.h" //weibo

#ifdef DEBUG
static DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static DDLogLevel ddLogLevel = DDLogLevelInfo;
#endif

#endif /* marco_h */
