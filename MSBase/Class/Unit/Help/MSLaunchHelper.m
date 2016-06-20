//
//  MSLaunchHelper.m
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSLaunchHelper.h"
#import "MSNavigationController.h"
#import "MSUserInfo.h"
#import "MSLogHelper.h"
#import "MSAnalyticsManager.h"
#import "MSHotUpdateManager.h"
#import "MSHttpConfig.h"

@interface MSLaunchHelper ()

@end

@implementation MSLaunchHelper

SB_ARC_SINGLETON_IMPLEMENT(MSLaunchHelper)

- (void)dealloc {
    
}

/** 注册功能 */
+ (void)install:(UIWindow *)window {
    [[MSLaunchHelper sharedMSLaunchHelper] install:window];
}

/** 注册功能 */
- (void)install:(UIWindow *)window {
    self.window = window;
    
    //界面
    [self ctrlDidLoad];
    
    //全局配置
    [self loadGolbalConfig];
    
    //日志打印
    [MSLogHelper install];
    
    //友盟统计
    [MSAnalyticsManager install];
    
    //热更新
    [MSHotUpdateManager install];
    
    //网络请求配置
    [MSHttpConfig install];
    
    //引导页
    NSMutableArray *guideArr = [NSMutableArray new];
    for (int i = 0; i < 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"welcome%d", i + 1];
        [guideArr addObject:imageName];
    }
    [MSHelper loadGuideViewToView:self.window
                             imageArr:guideArr
                        pageIconImage:nil
                pageSelectedIconImage:nil];
    
    //开机响应
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunchingNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    //界面进入后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    //界面进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

//应用启动
- (void)applicationDidFinishLaunchingNotification:(NSNotification *)noti {
}

- (void)applicationDidEnterBackgroundNotification:(NSNotification *)noti {
}

- (void)applicationDidBecomeActiveNotification:(NSNotification *)noti {
}

//从外部应用进入
+ (BOOL)openURL:(NSURL *)url {
//    NSString *scheme = url.scheme;
    
//    if ([scheme isEqualToString:[[EM3rdPassportConfig sharedInstance] wxAppId]]) {
//        return [WXApi handleOpenURL:url delegate:[ELLaunchHelper sharedELLaunchHelper]];
//    }
//    //以下为支付宝支付相关
//    else if ([url.host isEqualToString:@"safepay"]) {
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
//                                                  standbyCallback:^(NSDictionary *resultDic) {
//                                                      NSLog(@"result2 = %@",resultDic);
//                                                  }];
//        return NO;
//    }
//    //支付宝钱包快登授权返回 authCode
//    else if ([url.host isEqualToString:@"platformapi"]){
//        [[AlipaySDK defaultService] processAuthResult:url
//                                      standbyCallback:^(NSDictionary *resultDic) {
//                                          NSLog(@"result3 = %@",resultDic);
//                                      }];
//        return NO;
//    }
//    //新浪微博
//    else if ([url.scheme hasPrefix:@"wb"]) {
//        return [EM3rdSinaPassport handleOpenURL:url];
//    }
//    //qq
//    else if ([url.scheme hasPrefix:@"tencent"]) {
//        return [TencentOAuth HandleOpenURL:url];
//    }
    
    return YES;
}

/** 启动配制 */
+ (DataItemDetail *)launchInfo {
    DataItemDetail *launchInfo = [[MSAppCoreInfo getCoreDB] getDetailValue:STORE_CORE_APP_SETTINGS dataKey:@"ELGloBalConfig"];
    if (launchInfo) {
        return launchInfo;
    }
    return [DataItemDetail new];
}

//登录界面
- (MSNavigationController *)loginCtrl {
    MSURLAction *lAction = [MSURLAction actionWithClassName:@"MSLoginViewController"];
    UIViewController *lCtrl = [MSURLAction sb_initCtrl:lAction];
    MSNavigationController *lNav = [[MSNavigationController alloc] initWithRootViewController:lCtrl];
    return lNav;
}

//界面
- (void)ctrlDidLoad {
    UIViewController *ctrl = nil;
    if (![MSUserInfo hasLogined]) {
        ctrl = [self loginCtrl];
    }else {
        ctrl = [MSHelper getRootViewController];//tab界面
    }
    self.window.rootViewController = ctrl;
    [self.window makeKeyAndVisible];
}

//这个规则同时请求首页配制
- (void)loadGolbalConfig {
    
    
}

//通过登录状态加载界面
+ (void)launchMainCtrl:(DataItemDetail *)userInfo {
    [[MSLaunchHelper sharedMSLaunchHelper] launchMainCtrl:userInfo];
}

//通过登录状态加载界面
- (void)launchMainCtrl:(DataItemDetail *)userInfo {
    //同步数据
    [MSUserInfo updateUserDetail:userInfo];
    
    //登录状态
    [MSUserInfo updateLoginState:YES];
    
    //登录成功通知
}

@end
