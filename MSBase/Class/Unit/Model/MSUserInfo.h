//
//  MSUserInfo.h
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//
//用户信息
#import <Foundation/Foundation.h>


@interface MSUserInfo : NSObject

SB_ARC_SINGLETON_DEFINE(MSUserInfo)

//用户数据
+ (DataItemDetail *)getUserDetail;

/** 同步用户数据 */
+ (void)updateUserDetail:(DataItemDetail *)uDetail;

/**登录状态*/
+ (BOOL)hasLogined;

/**更新登录状态*/
+ (void)updateLoginState:(BOOL)logined;

+ (NSString *)userToken;

@end

