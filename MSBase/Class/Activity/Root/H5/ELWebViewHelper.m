//
//  ELWebViewHelper.m
//  EMLive
//
//  Created by menglingchao on 16/12/22.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "ELWebViewHelper.h"
#import <WebKit/WebKit.h>

#define ELWebViewClearCacheTimestamp @"ELWebViewClearCacheTimestamp"

@implementation ELWebViewHelper

/*!一天清除一次网页缓存*/
+ (void)clearCacheOnceADay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = [NSTimeZone localTimeZone];
    NSCalendarUnit currentFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components =  [calendar components:currentFlag fromDate:[NSDate date]];
    NSDate *date = [calendar dateFromComponents:components];
    NSString *currentTimeInterval = @(date.timeIntervalSince1970).stringValue;
    NSString *lastTimeInterval = [[SBAppCoreInfo getCoreDB] getStrValue:@"DEBUG_CACHE_TYPE" dataKey:ELWebViewClearCacheTimestamp];
    if (! [currentTimeInterval isEqualToString:lastTimeInterval]) {
        [ELWebViewHelper clearCache];
        [[SBAppCoreInfo getCoreDB] setStrValue:@"DEBUG_CACHE_TYPE" dataKey:ELWebViewClearCacheTimestamp dataValue:currentTimeInterval];
    }
}
+ (void)clearCache {//清除网页缓存
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];//清除cookies
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    if (APPCONFIG_VERSION_OVER_9) {
        //你可以选择性的删除一些你需要删除的文件 or 也可以直接全部删除所有缓存的type
        //                NSSet *websiteDataTypes = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,
        //                                                                WKWebsiteDataTypeOfflineWebApplicationCache,
        //                                                                WKWebsiteDataTypeMemoryCache,
        //                                                                WKWebsiteDataTypeLocalStorage,
        //                                                                WKWebsiteDataTypeCookies,
        //                                                                WKWebsiteDataTypeSessionStorage,
        //                                                                WKWebsiteDataTypeIndexedDBDatabases,
        //                                                                WKWebsiteDataTypeWebSQLDatabases]];
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                                   modifiedSince:dateFrom completionHandler:^{
                                                       
                                                   }];
    } else {
        NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)[0];
        NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleIdentifier"];
        NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
        NSString *webKitFolderInCaches = [NSString stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
        
        NSError *error;
        /* iOS8.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
        //另外
        NSString *cookiesFolderPath = [libraryDir stringByAppendingString:@"/Cookies"];
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&error];
    }
}
+ (void)modifyUserAgent {//修改userAgent，用于h5页面后台判断
    //get the original user-agent of webview
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    //add my info to the new agent
    NSString *appendAgent = [NSString stringWithFormat:@"eastmoney_%@_ios_%@",EL3rdConfig(@"appType"),[SBAppCoreInfo shortVersionString]];
    NSString *newAgent = [oldAgent stringByAppendingString:appendAgent];
    //    NSLog(@"new agent :%@", newAgent);
    
    //regist the new agent
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
    [SBUserDefaults registerDefaults:dictionnary];
}
+ (void)clearPartCookie {//清理特定的cookie
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies])  {
        if ([cookie.name isEqualToString:@"ctoken"] || [cookie.name isEqualToString:@"utoken"] || [cookie.name isEqualToString:@"pi"]) {
            [storage deleteCookie:cookie];
        }
    }
}

@end
