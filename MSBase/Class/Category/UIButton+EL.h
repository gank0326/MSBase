//
//  UIButton+EL.h
//  EMLive
//
//  Created by roronoa on 16/5/7.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ELBtnAction)(UIButton *button);
//为SDK自带的 UIButton 类添加一些实用方法
@interface UIButton (elbutton)

@property (nonatomic, copy) ELBtnAction btnAction;
/**浪客标准样式*/
- (void)el_main;
/**点击带缩放*/
- (void)el_scaleEffect;

//- (void)el_addBlockAction:(ELBtnAction)action;

@end

#define kDefaultSubTitle @"ss秒"
//
@interface UIButton (eltime)

@property (nonatomic, assign) NSNumber *currentTime;//倒计时的当前时间
@property (nonatomic, strong) NSTimer *resendTimer;//定时器

/*
 *    倒计时按钮
 *    @param timeLine  倒计时总时间
 *    @param title     还没倒计时的title
 *    @param subTitle  倒计时的子名字 格式为xxssxx，xx为你要显示的文字，不传则默认为：ss秒
 *    @param mColor    还没倒计时的颜色
 *    @param color     倒计时的颜色
 */

- (void)el_startWithTime:(NSInteger)second title:(NSString *)title subTitle:(NSString *)subTitle mainColor:(UIColor *)mColor grayColor:(UIColor *)gColor;

- (void)el_removeTimer;

@end
