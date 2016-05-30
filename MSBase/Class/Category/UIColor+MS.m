//
//  UIColor+MS.m
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "UIColor+MS.h"

@implementation UIColor (MS)
/** 导航栏颜色 */
+ (UIColor *)el_navBarColor {
    return RGB(0xf6, 0xf6, 0xf6);
}

/** 导航栏标题颜色 */
+ (UIColor *)el_navTitleColor {
    return RGB(0x33, 0x33, 0x33);
}

/** 导航栏控件颜色 */
+ (UIColor *)el_navItemColor {
    return RGB(0xff, 0x68, 0x27);
}

/** 界面背景色颜色 */
+ (UIColor *)el_viewBackColor {
    return RGB(0xed, 0xed, 0xed);
}

/** 分割线颜色 */
+ (UIColor *)el_lineColor {
    return RGB(0xcc, 0xcc, 0xcc);
}

/** 标题颜色 */
+ (UIColor *)el_titleColor {
    return RGB(0x33, 0x33, 0x33);
}

/** 副标题颜色 */
+ (UIColor *)el_subTitleColor {
    return RGB(0x6d, 0x6d, 0x72);
}

/** 灰色标签颜色 */
+ (UIColor *)el_labelTitleColor {
    return RGB(0x88, 0x88, 0x88);
}

/** 正文颜色 */
+ (UIColor *)el_contentColor {
    return RGB(0x33, 0x33, 0x33);
}

/** 备注颜色 */
+ (UIColor *)el_remarkColor {
    return RGB(0x80, 0x80, 0x80);
}

/** 已读标题颜色 */
+ (UIColor *)el_titleReadedColor {
    return RGB(0x8e, 0x8e, 0x93);
}

/** 时间颜色 */
+ (UIColor *)el_subTitleTimeColor {
    return RGB_HEX(0x999999);
}

/** 等级背景色 */
+ (UIColor *)el_leverBGColor {
    return RGB_HEX(0xff9666);
}

/** 主色调 */
+ (UIColor *)el_mainColor {
    return RGB(0xff, 0x68, 0x27);
}
@end
