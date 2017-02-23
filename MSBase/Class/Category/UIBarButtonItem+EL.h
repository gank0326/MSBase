//
//  UIBarButtonItem+EL.h
//  EMLive
//
//  Created by wusicong on 16/6/12.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define elNavBackBtnTag 1000;

@interface UIBarButtonItem (EL)

+ (UIBarButtonItem *)el_itemImage:(UIImage *)image target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)el_titleBtnItem:(NSString*)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)el_itemTitle:(NSString *)title font:(UIFont *)font target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)el_itemImage:(UIImage *)image title:(NSString *)title titleInsets:(UIEdgeInsets)titleInsets target:(id)target action:(SEL)action;



#pragma mark - 导航上的按钮，事件为block（推荐这种方法）
/**导航上的文字按钮*/
+ (UIBarButtonItem *)el_itemWithTitle:(NSString*)title action:(void (^)())action;

@end
