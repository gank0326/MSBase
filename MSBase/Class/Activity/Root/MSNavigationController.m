//
//  MSNavigationController.m
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSNavigationController.h"
#import "MSNavigationBar.h"

@interface MSNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
{
}

@property (nonatomic, weak) UIViewController *currentShowVC;
@property (nonatomic, copy) dispatch_block_t completionBlock;
@property (nonatomic, weak) UIViewController *pushedVC;

@end

@implementation MSNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeSkin];
    self.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        __weak MSNavigationController *weakSelf = self;
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    self.delegate = self;
}

// Hijack the push method to disable the gesture

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(dispatch_block_t)completion {
    self.pushedVC = viewController;
    self.completionBlock = completion;
    [self pushViewController:viewController animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.pushedVC != viewController) {
        self.pushedVC = nil;
        self.completionBlock = nil;
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    BOOL isTopViewControllerSLViewController = [self.topViewController isKindOfClass:[MSViewController class]];
    if (isTopViewControllerSLViewController) {
        MSViewController *topViewController = (MSViewController *)self.topViewController;
        if (topViewController.animating) {
            return;
        }
    }
    if ([viewController isKindOfClass:[MSViewController class]]) {
        MSViewController *castViewController = (MSViewController *)viewController;
        castViewController.animating = animated;
        if (isTopViewControllerSLViewController) {
            MSViewController *topViewController = (MSViewController *)self.topViewController;
            topViewController.animating = animated;
        }
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if ([self.topViewController isKindOfClass:[MSViewController class]]) {
        MSViewController *castViewController = (MSViewController *)self.topViewController;
        castViewController.animating = animated;
        [castViewController willPopupFromNavigation];
    }
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    for (NSUInteger i = self.viewControllers.count - 1; i > 0; i--) {
        if ([self.viewControllers[i] isKindOfClass:[MSViewController class]]) {
            MSViewController *castViewController = (MSViewController *)self.viewControllers[i];
            castViewController.animating = animated;
            [castViewController willPopupFromNavigation];
        }
    }
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    if (navigationController.viewControllers.count == 1) {
        self.currentShowVC = nil;
    }
    else {
        self.currentShowVC = viewController;
    }
    
    if (self.completionBlock && self.pushedVC == viewController) {
        self.completionBlock();
        self.completionBlock = nil;
        self.pushedVC = nil;
    }
}

- (void)changeSkin {
    MSNavigationBar *bar = (MSNavigationBar *)self.navigationBar;
    if (bar && [bar isKindOfClass:[MSNavigationBar class]]) {
        [bar setCustomBarTintColor:kThemeColor];
        [bar setShadowImage:[UIImage new]];
    }
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(0, 0);
    NSDictionary *titleAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                      NSShadowAttributeName: shadow,
                                      NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0]};
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
    self.navigationBar.titleTextAttributes = titleAttributes;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithNavigationBarClass:[MSNavigationBar class] toolbarClass:nil];
    if (self) {
        self.viewControllers = @[rootViewController];
    }
    return self;
}

- (UIViewController *)showingTopViewController {
    if (self.currentShowVC) {
        return _currentShowVC;
    }
    return [self topViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
