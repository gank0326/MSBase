//
//  MSHelper+Navigation.h
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSHelper.h"
@class MSTabBarController;
@class MSNavigationController;

@interface MSHelper (Navigation)
+ (void)popupToMainTab;

+ (MSTabBarController *)getMainView;

+ (void)navToMainView;

+ (void)pushViewController:(UIViewController *)controller showNavBar:(BOOL)show;

+ (void)popupTopViewController:(BOOL)animate;

+ (void)pushViewControllerAtFirstMainTab:(UIViewController *)controller animate:(BOOL)animate;

+ (void)presentModelViewController:(UIViewController *)controller;

+ (void)dismissModelViewController;

+ (void)setRootViewController:(UIViewController *)controller;

+ (UINavigationController *)getRootViewController;

+ (void)setMainTabNil;

+ (MSTabBarController *)mainTab;

+ (MSNavigationController *)currentNavigationController;

+ (MSNavigationController *)getNavViewController:(UIViewController *)root;

+ (BOOL)isCurrentViewControllerOnTop:(UIViewController *)controller;
@end
