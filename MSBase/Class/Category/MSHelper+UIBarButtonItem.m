//
//  MSHelper+UIBarButtonItem.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSHelper+UIBarButtonItem.h"

@implementation MSHelper (UIBarButtonItem)

+ (UIBarButtonItem *)getRightUIBarBtnItemWithImage:(UIImage *)image
                                        withTarget:(id)target withSEL:(SEL)sel {
    int width = 50;
    CGRect frameimg = CGRectMake(0, 0, width, image.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setImage:image forState:UIControlStateNormal];
    [someButton setImage:image forState:UIControlStateHighlighted];
    [someButton setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    [someButton addTarget:target action:sel
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    return barItem;
}


+ (UIBarButtonItem *)getNavBtn:(NSString *)imageName
                    withTarget:(id)target withSEL:(SEL)sel {
    UIImage *icon = [UIImage imageNamed:imageName];
    return [MSHelper getNavBtnWithImage:icon withTarget:target withSEL:sel];
}

+ (UIBarButtonItem *)getNavBtnWithImage:(UIImage *)icon
                             withTarget:(id)target withSEL:(SEL)sel {
    int width = 50;
    CGRect frameimg = CGRectMake(0, 0, width, icon.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setImage:icon forState:UIControlStateNormal];
    [someButton setImage:icon forState:UIControlStateHighlighted];
    
    [someButton setImageEdgeInsets:UIEdgeInsetsMake(0, 18, 0, -18)];
    
    [someButton addTarget:target action:sel
         forControlEvents:UIControlEventTouchUpInside];
    someButton.showsTouchWhenHighlighted = NO;
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    return barItem;
}

+ (UIBarButtonItem *)getNavBtnNormal:(UIImage *)normalImageName hightlighit:(UIImage *)hImage
                          withTarget:(id)target withSEL:(SEL)sel {
    int width = 50;
    CGRect frameimg = CGRectMake(0, 0, width, normalImageName.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setImage:normalImageName forState:UIControlStateNormal];
    [someButton setImage:hImage forState:UIControlStateHighlighted];
    [someButton addTarget:target action:sel
         forControlEvents:UIControlEventTouchUpInside];
    someButton.showsTouchWhenHighlighted = NO;
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    return barItem;
}

+ (UIBarButtonItem *)getLeftUIBarBtnItemWithTarget:(id)target withSEL:(SEL)sel {
    UIButton *someButtom = [MSHelper getNavButtonWithNormalImage:[UIImage imageNamed:@"ms_nav_back"] withHighLightImage:[UIImage imageNamed:@"ms_nav_back"] withTarget:target withSEL:sel];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:someButtom];
    return barItem;
}

+ (UIButton *)getNavButtonWithNormalImage:(UIImage *)image withHighLightImage:(UIImage *)hightLightImage
                               withTarget:(id)target withSEL:(SEL)sel {
    int width = 50;
    CGRect frameimg = CGRectMake(0, 0, width, image.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setImage:image forState:UIControlStateNormal];
    [someButton setImage:hightLightImage forState:UIControlStateHighlighted];
    [someButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
    
    [someButton setImageEdgeInsets:UIEdgeInsetsMake(0, -22, 0, 22)];
    
    [someButton addTarget:target action:sel
         forControlEvents:UIControlEventTouchUpInside];
    someButton.accessibilityHint = @"UIBarButtonItem_Left";
    [someButton setShowsTouchWhenHighlighted:NO];
    return someButton;
}

+ (UIBarButtonItem *)getConfirmBtnItemWithTarget:(id)target withSEL:(SEL)sel {
    int width = 50;
    CGRect frameimg = CGRectMake(0, 0, width, 40);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
    [someButton setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateHighlighted];
    [someButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [someButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [someButton addTarget:target action:sel
         forControlEvents:UIControlEventTouchUpInside];
    
    [someButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [someButton setShowsTouchWhenHighlighted:NO];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    return barItem;
}

+ (UIBarButtonItem *)getTextItemWithTarget:(NSString *)title forTarget:(id)target withSEL:(SEL)sel {
    
    float fontSize = 14.0;
    int width = [MSUtil widthForString:title fontSize:14.0] + 20;
    CGRect frameimg = CGRectMake(0, 0, width, 40);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setTitle:title forState:UIControlStateNormal];
    [someButton setTitle:title forState:UIControlStateHighlighted];
    someButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [someButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [someButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [someButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
    [someButton addTarget:target action:sel
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [someButton setShowsTouchWhenHighlighted:NO];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    return barItem;
}

+ (UIBarButtonItem *)getLeftTextItemWithTarget:(NSString *)title forTarget:(id)target withSEL:(SEL)sel {
    float fontSize = 14.0;
    int width = [MSUtil widthForString:title fontSize:14.0] + 20;
    CGRect frameimg = CGRectMake(0, 0, width, 40);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setTitle:title forState:UIControlStateNormal];
    someButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [someButton setTitle:title forState:UIControlStateHighlighted];
    [someButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [someButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [someButton removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
    [someButton addTarget:target action:sel
         forControlEvents:UIControlEventTouchUpInside];
    
    [someButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [someButton setShowsTouchWhenHighlighted:NO];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    return barItem;
}

@end
