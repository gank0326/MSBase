//
//  MSHttpConfig.m
//  MSBase
//
//  Created by ganshunwei on 16/6/20.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSHttpConfig.h"
#import "YTKNetworkConfig.h"
#import "YTKNetworkAgent.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation MSHttpConfig

SB_ARC_SINGLETON_IMPLEMENT(MSHttpConfig)

+ (void)install {
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    [agent setValue:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html",@"text/css", nil]
         forKeyPath:@"_manager.responseSerializer.acceptableContentTypes"];
    YTKNetworkConfig *ytkNetworkConfig = [YTKNetworkConfig sharedConfig];
    [ytkNetworkConfig setBaseUrl:API_BASE_URL];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}


@end
