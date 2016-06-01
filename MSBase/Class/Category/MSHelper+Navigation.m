//
//  MSHelper+Navigation.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSHelper+Navigation.h"
#import "MSTabBarController.h"
#import "MSNavigationController.h"
#import "AppDelegate.h"
#import "MSNavigationBar.h"

@implementation MSHelper (Navigation)

+ (void)popupToMainTab {
    [[MSHelper currentNavigationController] popToRootViewControllerAnimated:YES];
}

static MSTabBarController *mainTab = nil;

+ (MSTabBarController *)getMainView {
    if (!mainTab) {
        mainTab = [[MSTabBarController alloc] init];
    }
    return mainTab;
}

+ (void)navToMainView {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = [MSHelper getRootViewController];
}

+ (UINavigationController *)getRootViewController {
    return [MSHelper getNavViewController:[MSHelper getMainView]];
}

+ (MSNavigationController *)currentNavigationController {
    UITabBarController *tabbarVc = (UITabBarController *)[MSHelper mainTab];
    UINavigationController *nav = tabbarVc.navigationController;
    return (MSNavigationController *)nav;
}

+ (MSNavigationController *)getNavViewController:(UIViewController *)root {
    MSNavigationController *nav = [[MSNavigationController alloc] initWithNavigationBarClass:[MSNavigationBar class] toolbarClass:nil];
    [nav pushViewController:root animated:NO];
    return nav;
}

#pragma mark - UINavigationController Helper

+ (void)pushViewController:(UIViewController *)controller showNavBar:(BOOL)show {
    UINavigationController *nav = [MSHelper currentNavigationController];
    nav.navigationBar.hidden = !show;
    UIViewController *pnav = [nav.topViewController presentedViewController];
    if (pnav) {
        if ([pnav isKindOfClass:[UINavigationController class]]) {
            UINavigationController *root = (UINavigationController *)pnav;
            [root pushViewController:controller animated:YES];
            return;
        }
    }
    [nav pushViewController:controller animated:YES];
}

+ (void)pushViewControllerAtFirstMainTab:(UIViewController *)controller animate:(BOOL)animate {
    MSNavigationController *nav = (MSNavigationController *)[MSHelper currentNavigationController];
    if ([MSHelper mainTab].selectedIndex == 0) {
        [nav popToRootViewControllerAnimated:NO];
        [nav pushViewController:controller animated:animate];
    }
    else {
        [nav pushViewController:controller animated:animate completion: ^{
            [MSHelper mainTab].selectedIndex = 0;
            [MSHelper mainTab].selectedIndex = 0;
            nav.viewControllers = @[[MSHelper mainTab], controller];
        }];
    }
}

+ (void)popupTopViewController:(BOOL)animate {
    UINavigationController *nav = [MSHelper currentNavigationController];
    [nav popViewControllerAnimated:animate];
}

+ (void)setRootViewController:(UIViewController *)controller {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = controller;
}

+ (void)presentModelViewController:(UIViewController *)controller {
    UINavigationController *nav = [MSHelper currentNavigationController];
    [nav.topViewController presentViewController:controller animated:YES completion:^{
    }];
}

+ (void)dismissModelViewController {
    UINavigationController *nav = [MSHelper currentNavigationController];
    [nav.topViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

+ (void)setMainTabNil {
    mainTab = nil;
}

+ (MSTabBarController *)mainTab {
    return mainTab;
}

+ (BOOL)isCurrentViewControllerOnTop:(UIViewController *)controller {
    return [(MSNavigationController *)[MSHelper currentNavigationController] showingTopViewController] == controller;
}

@end
