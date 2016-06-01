//
//  AppDelegate.m
//  MSBase
//
//  Created by ganshunwei on 16/5/25.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "AppDelegate.h"
#import "MSLaunchHelper.h"
#import "MSPushService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark -
#pragma mark 应用生命周期
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //窗口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];         //不设置 很多隐藏tab的界面会有黑条
    
    //开机动效
#warning 动效效果暂缓
    [self handleLaunchScreen];
    
    //加载管理
    [MSLaunchHelper install:self.window];
    
    //极光推送
    [MSPushService install:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - ----------------------系统推送注册回调--------------------

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    [ELPushManager didRegister:deviceToken];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    [ELPushManager didFailed:error];
}

#pragma mark - ----------------------接收推送消息的回调--------------------

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [ELPushManager didRecieve:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
}

#pragma mark - ----------------------URL跳转--------------------
//从外部应用进入
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    return [MSLaunchHelper openURL:url];
}

//从外部应用进入
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [MSLaunchHelper openURL:url];
}

#pragma mark - Self Manage Method

- (void)handleLaunchScreen {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    //    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"ELLaunchScreen"];
    //
    //    UIView *launchView = viewController.view;
    //    UIWindow *mainWindow = self.window;//[UIApplication sharedApplication].keyWindow;
    //    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    //    [mainWindow addSubview:launchView];
    //
    //    [UIView animateWithDuration:1.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //        launchView.alpha = 0.0f;
    //        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5f, 1.5f, 1.0f);
    //    } completion:^(BOOL finished) {
    //        if (finished) {
    //            [launchView removeFromSuperview];
    //            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    //        }
    //    }];
}


@end
