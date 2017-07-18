//
//  MSNavigationBar.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSNavigationBar.h"

@interface MSNavigationBar ()

@end

@implementation MSNavigationBar

- (void)setCustomBarImage:(UIImage *)image {
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = [[UIImage alloc] init];
}

- (void)setCustomBarTintColor:(UIColor *)barTintColor {
    
    NSArray *list=self.subviews;
    for (id obj in list) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView=(UIImageView *)obj;
            imageView.hidden=YES;
        }
    }
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, APPCONFIG_UI_SCREEN_FWIDTH, 64)];
    imageView.image=[UIImage sb_imageWithColor:barTintColor];
    [self addSubview:imageView];
    [self sendSubviewToBack:imageView];
}

@end
