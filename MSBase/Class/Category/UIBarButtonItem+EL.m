//
//  UIBarButtonItem+EL.m
//  EMLive
//
//  Created by wusicong on 16/6/12.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "UIBarButtonItem+EL.h"

@implementation UIBarButtonItem (EL)

/** 导航上的文字按钮 */
+ (UIBarButtonItem *)el_titleBtnItem:(NSString*)title target:(id)target action:(SEL)action {
    return [self el_itemTitle:title font:[UIFont systemFontOfSize:16] target:target action:action];
}

/**
 *  根据图标生成UIBarButtonItem
 *
 *  @param image    图标
 *  @param target   目标
 *  @param selector 动作
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)el_itemImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [itemBtn setImage:image forState:UIControlStateNormal];
    [itemBtn sizeToFit];
    
    [itemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    return item;
}

/**
 *  根据文字生成UIBarButtonItem
 *
 *  @param title    文字
 *  @param font     字体
 *  @param target   目标
 *  @param selector 动作
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)el_itemTitle:(NSString *)title font:(UIFont *)font target:(id)target action:(SEL)action {
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [itemBtn.titleLabel setFont:font];
    [itemBtn setTitle:title forState:UIControlStateNormal];
    [itemBtn sizeToFit];
    
    [itemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    return item;
}

+ (UIBarButtonItem *)el_itemImage:(UIImage *)image title:(NSString *)title titleInsets:(UIEdgeInsets)titleInsets target:(id)target action:(SEL)action {
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [itemBtn setImage:image forState:UIControlStateNormal];
    
    [itemBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [itemBtn setTitleEdgeInsets:titleInsets];
    [itemBtn setTitle:title forState:UIControlStateNormal];
    [itemBtn sizeToFit];
    
    //系统粗体时，button的imageView坐标偏移，校正imageView坐标
    if (CGRectGetMinX(itemBtn.imageView.frame)) {
        CGFloat offset = CGRectGetMinX(itemBtn.imageView.frame);
        UIEdgeInsets imageInsets = UIEdgeInsetsMake(0, -offset, 0, offset);
        [itemBtn setImageEdgeInsets:imageInsets];
    }

    [itemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    return item;
}

/**导航上的文字按钮*/
+ (UIBarButtonItem *)el_itemWithTitle:(NSString*)title action:(void (^)())action {
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [itemBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [itemBtn setTitle:title forState:UIControlStateNormal];
    [itemBtn sizeToFit];
    itemBtn.btnAction = action;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    return item;
}

@end
