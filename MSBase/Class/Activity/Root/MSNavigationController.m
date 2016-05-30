//
//  MSNavigationController.m
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSNavigationController.h"

@interface MSNavigationController ()<UINavigationControllerDelegate>

@end

@implementation MSNavigationController

//重写初始化
- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    
    UINavigationBar *navBar = self.navigationBar;
    
    //背景色
    UIImage *bgimage = [UIImage sb_imageWithColor:[UIColor el_navBarColor]];
    [navBar setBackgroundImage:bgimage forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                     NSForegroundColorAttributeName:[UIColor el_navTitleColor]}];
    navBar.translucent = NO;
    navBar.tintColor = [UIColor el_navItemColor];
    navBar.barTintColor = [UIColor el_navBarColor];
    
    //添加手势返回 IOS7及以上系统才能使用
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    self.delegate = self;
    
    return self;
}

-(UIBarButtonItem *)customLeftBackButton {
    UIImage *image = [UIImage imageNamed:@"ms_nav_back"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 30);
    [btn setImage:image forState:UIControlStateNormal];
    //    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitleColor:[UIColor el_mainColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(5, -13, 5, 30)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -24, 0, 0)];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return backItem;
}

-(void)popself {
    [self popViewControllerAnimated:YES];
}

// Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem =[self customLeftBackButton];
    }
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}


@end
