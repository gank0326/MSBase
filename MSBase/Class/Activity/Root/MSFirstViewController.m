
//
//  MSFirstViewController.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSFirstViewController.h"

@interface MSFirstViewController ()
{
    UILabel *lableTitleView;
}
@end

@implementation MSFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.autoCreateBackButtonItem = NO;
}

/**
 *  第一个级别的 navigationItem 需要复写了，只有最顶层一个UINavigationViewController
 *
 *  @return
 */
- (UINavigationItem *)navigationItem {
    
    UIViewController *mainTab = (UIViewController *)[MSHelper mainTab];
    return  mainTab.navigationItem;
//    return (MSTabBarController *)[MSHelper mainTab].navigationItem;
}

/**
 *  强迫显示状态栏，因为某些页面没有状态栏，收到震通知会导致状态栏消失
 *
 *  @param animated
 */

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([UIApplication sharedApplication].statusBarHidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    if (self.navigationController.navigationBarHidden) {
        [[MSHelper currentNavigationController] setNavigationBarHidden:NO animated:NO];
    }
}

- (void)setTabBarHidden:(BOOL)hidden
{
    UIView *tab = self.tabBarController.view;
    
    if ([tab.subviews count] < 2) {
        return;
    }
    UIView *view;
    
    if ([[tab.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        view = [tab.subviews objectAtIndex:1];
    } else {
        view = [tab.subviews objectAtIndex:0];
    }
    
    if (hidden) {
        view.frame = tab.bounds;
    } else {
        view.frame = CGRectMake(tab.bounds.origin.x, tab.bounds.origin.y, tab.bounds.size.width, tab.bounds.size.height);
    }
    self.view.frame = view.frame;
    self.tabBarController.tabBar.hidden = hidden;
}

#pragma mark - Slot

- (void)setTitle:(NSString *)title {
    if (!lableTitleView
        || ![lableTitleView isKindOfClass:[UILabel class]]) {
        lableTitleView = [[UILabel alloc] initWithFrame:CGRectZero];
        lableTitleView.backgroundColor = [UIColor clearColor];
        lableTitleView.font = [UIFont boldSystemFontOfSize:17.0];
    }
    lableTitleView.textColor = [UIColor whiteColor];
    lableTitleView.text = title;
    [lableTitleView sizeToFit];
    [self setTitleView:lableTitleView];
}
@end
