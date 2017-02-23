//
//  ELWebViewHelper.h
//  EMLive
//
//  Created by menglingchao on 16/12/22.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELWebViewHelper : NSObject

///*!一天清除一次网页缓存*/
//+ (void)clearCacheOnceADay;//1.7.0不需要该方法
/*!清除网页缓存*/
+ (void)clearCache;
/*!修改userAgent，用于h5页面后台判断*/
+ (void)modifyUserAgent;
/*!清理特定的cookie*/
+ (void)clearPartCookie;

@end
