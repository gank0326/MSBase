//
//  MSAnalyticsManager.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSAnalyticsManager.h"

static NSString *const UMAppKey  = @"58ad5e5899f0c73323001a2b";

@implementation MSAnalyticsManager

+ (void)install {
    UMAnalyticsConfig *config = [UMAnalyticsConfig sharedInstance];
    config.appKey = UMAppKey;
    config.bCrashReportEnabled = YES;
    [MobClick startWithConfigure:config];
    [MobClick setAppVersion:[MSAppCoreInfo shortVersionString]];
    [MobClick setCrashReportEnabled:YES];
    [MobClick setLogSendInterval:3600];
    
    //分享设置
    [UMSocialData setAppKey:UMAppKey];
    [UMSocialWechatHandler setWXAppId:EL3rdConfig(@"wxAppId") appSecret:EL3rdConfig(@"wxAppSecret") url:nil];
    [UMSocialQQHandler setQQWithAppId:EL3rdConfig(@"qqAppId") appKey:EL3rdConfig(@"qqAppSecret") url:EL3rdConfig(@"qqURL")];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:EL3rdConfig(@"sinaWeiboAppId")
                                              secret:EL3rdConfig(@"sinaWeiboAppSecret")
                                         RedirectURL:EL3rdConfig(@"sinaWeiboURL")];
}

@end
