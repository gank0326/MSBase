//
//  MSPushService.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSPushService.h"
#import "MSUserInfo.h"

@implementation MSPushService

+ (void)install:(NSDictionary *)launchOptions {
    [[MSPushService sharedMSPushService] initJPush:launchOptions];
}

SB_ARC_SINGLETON_IMPLEMENT(MSPushService)

-(void)initJPush:(NSDictionary *)launchOptions {
    
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    
    [JPUSHService setupWithOption:launchOptions
                           appKey:@"2687e120fcae25d66553af02"
                          channel:@"官网"
                 apsForProduction:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidReceiveMessage:)
                                                 name:kJPFNetworkDidReceiveMessageNotification
                                               object:nil];
}

//设置别名（后台用与区分用户）
- (void)setTagsAndAlias
{
    NSMutableSet *tags = [NSMutableSet set];
    [tags addObject:@"ios"];
    [JPUSHService setTags:tags
                    alias:[MSUserInfo userToken]
    fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        
    }];
}

- (void)clearTagsAndAlias {
    [JPUSHService setTags:[NSSet set] alias:@"" callbackSelector:nil object:nil];
}

#pragma mark - jpush 透传信息
- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    //    NSDictionary * userInfo = [notification userInfo];
}

- (void)registerDeviceToken:(NSData *)token {
    [JPUSHService registerDeviceToken:token];
}

- (void)handleRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
}

@end
