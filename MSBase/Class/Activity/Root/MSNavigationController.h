//
//  MSNavigationController.h
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSNavigationController : UINavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(dispatch_block_t)completion;

- (UIViewController *)showingTopViewController;


@end
