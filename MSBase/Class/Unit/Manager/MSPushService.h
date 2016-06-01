//
//  MSPushService.h
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSPushService : NSObject

+ (void)install:(NSDictionary *)launchOptions;

SB_ARC_SINGLETON_DEFINE(MSPushService)

- (void)initJPush:(NSDictionary *)launchOptions;

- (void)registerDeviceToken:(NSData *)token;

- (void)handleRemoteNotification:(NSDictionary *)userInfo;

- (void)setTagsAndAlias;

- (void)clearTagsAndAlias;

@end
