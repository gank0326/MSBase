//
//  HZUIViewForGuide.h
//  Constraint
//
//  Created by huazi on 14-5-28.
//  Copyright (c) 2014年 AutoLayoutTestDemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSMyPageControl.h"
@interface MSGuideView : UIView

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) MSMyPageControl *pageControl;

- (void)initSubviews:(UIWindow *)window picArr:(NSArray*)imageArr pageIcon:(UIImage*)icon pageSelectedIcon:(UIImage*)selectedIcon;

@end
