//
//  MSTabBarController.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSTabBarController.h"

@interface MSTabBarController () <UITabBarControllerDelegate>
{
    UIViewController *lastSelectedViewController;
    NSDate *lastClickTabDate;
}
@end

@implementation MSTabBarController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavController];
    [self setupAppearance];
}


- (void)setupNavController {
    
    MSViewController *home = [MSViewController new];
    MSViewController *circle = [MSViewController new];
    //    MQHospitalViewController *activity = [MQHospitalViewController new];
    MSViewController *me = [MSViewController new];
    self.viewControllers = @[home,circle,me];
    self.delegate = self;
}

- (void)setupAppearance {
    
    
    //    self.tabBar.barTintColor = [@"f0f0f0" toColor];
    self.tabBar.translucent = YES;
    //    [self.tabBar setBarStyle:UIBarStyleBlack];
    //    self.tabBar.backgroundImage = [UIImage imageNamed:@"tab_main_background.png"];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIFont fontWithName:@"AmericanTypewriter" size:12.0f], NSFontAttributeName,
                                                       [@"222222" toColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIFont fontWithName:@"AmericanTypewriter" size:12.0f], NSFontAttributeName,
                                                       [UIColor redColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    UIImage *tab1 = [UIImage imageNamed:@"tabHome.png"];
    UIImage *tab1s = [UIImage imageNamed:@"tabHomeSelected.png"];
    tab1 = [tab1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab1s = [tab1s imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ((UIViewController *)[self.viewControllers objectAtIndex:0]).tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"首页", nil) image:tab1 selectedImage:tab1s];
    
    UIImage *tab2 = [UIImage imageNamed:@"tabCircle.png"];
    UIImage *tab2s = [UIImage imageNamed:@"tabCircleSelected.png"];
    tab2 = [tab2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab2s = [tab2s imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ((UIViewController *)[self.viewControllers objectAtIndex:1]).tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"圈子", nil) image:tab2 selectedImage:tab2s];
    
    
    //    UIImage *tab4 = [UIImage imageNamed:@"tabActivity.png"];
    //    UIImage *tab4s = [UIImage imageNamed:@"tabActivitySelected.png"];
    //    tab4 = [tab4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    tab4s = [tab4s imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    ((UIViewController *)[self.viewControllers objectAtIndex:2]).tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"医院", nil) image:tab4 selectedImage:tab4s];
    
    UIImage *tab5 = [UIImage imageNamed:@"tabMe.png"];
    UIImage *tab5s = [UIImage imageNamed:@"tabMeSelected.png"];
    tab5 = [tab5 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tab5s = [tab5s imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ((UIViewController *)[self.viewControllers objectAtIndex:2]).tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"我", nil) image:tab5 selectedImage:tab5s];
    
    //    [(UITabBarItem *)[self.tabBar.items objectAtIndex:2] setImageInsets:UIEdgeInsetsMake(-2, 2.5, 2, -2.5)];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (viewController == lastSelectedViewController) {
        //tab same view contoller
        NSTimeInterval interval = [lastClickTabDate timeIntervalSinceNow];
        if (fabs(interval) < 1) {
            [self doubleClickTab:viewController];
        }
    }
    if (tabBarController.selectedIndex == 1) {
        
        
    }else if (tabBarController.selectedIndex == 2){
        
    }
    lastClickTabDate = [NSDate date];
    lastSelectedViewController = viewController;
}

- (void)doubleClickTab:(UIViewController *)controller {
    if (self.selectedIndex == 0) {
        
    }
}

- (void)dealloc {
    self.viewControllers = nil;
}

@end