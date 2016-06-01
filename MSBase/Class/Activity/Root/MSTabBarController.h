//
//  MSTabBarController.h
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSTabBarController : UITabBarController

- (void)setupAppearance;
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end
