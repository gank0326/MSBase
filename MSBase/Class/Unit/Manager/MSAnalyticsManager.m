//
//  MSAnalyticsManager.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSAnalyticsManager.h"

static NSString *const UMAppKey  = @"563df57367e58ec175001cbd";

@implementation MSAnalyticsManager

+ (void)install {
    UMAnalyticsConfig *config = [UMAnalyticsConfig sharedInstance];
    config.appKey = UMAppKey;
    config.bCrashReportEnabled = YES;
    [MobClick startWithConfigure:config];
    [MobClick setAppVersion:[MSAppCoreInfo shortVersionString]];
    [MobClick setCrashReportEnabled:YES];
    [MobClick setLogSendInterval:3600];
}

@end
