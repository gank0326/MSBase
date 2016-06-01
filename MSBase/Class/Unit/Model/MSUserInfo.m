//
//  MSUserInfo.m
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSUserInfo.h"

@implementation MSUserInfo

SB_ARC_SINGLETON_IMPLEMENT(MSUserInfo)

//用户数据
+ (DataItemDetail *)getUserDetail {
    return [DataItemDetail new];
}

/** 同步用户数据 */
+ (void)updateUserDetail:(DataItemDetail *)uDetail {
    
}

/**登录状态*/
+ (BOOL)hasLogined {
    return YES;
}

/**更新登录状态*/
+ (void)updateLoginState:(BOOL)logined {
    
}

+ (NSString *)userToken {
    return @"21";
}
@end
