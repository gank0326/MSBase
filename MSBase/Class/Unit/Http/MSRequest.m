//
//  MSRequest.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSRequest.h"

@implementation MSRequest

- (MSRequest *)init {
    if (self = [super init]) {
        self.cacheTime = -1;
    }
    return self;
}

//统一处理业务失败
- (void)requestCompleteFilter
{
    [super requestCompleteFilter];
//    if ([[self responseJSONObject][@"code"] isEqualToString:@"8060"]) {
//        //用户被封禁
//        [[NSNotificationCenter defaultCenter] postNotificationName:kYPP_USER_FORBIDDEN object:nil];
//    }
}

-(YTKRequestMethod)requestMethod
{
    return self.methodType;
}

- (NSString *)requestUrl {
    return self.methodUrl;
}

-(id)requestArgument
{
    NSMutableDictionary *argumentDic = [MSUtil requestArgumentWithBody:self.argument];
    DDLogVerbose(@"请求地址为%@,参数为:%@",[self requestUrl],argumentDic);
    return argumentDic;
}

- (NSInteger)cacheTimeInSeconds {
    return self.cacheTime;
}
@end
