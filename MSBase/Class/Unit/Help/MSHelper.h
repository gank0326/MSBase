//
//  MSHelper.h
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSHelper : NSObject

/**
 *  加载app引导页
 *
 *  @param applicationWindown APP window
 *  @param imageArr           引导页图片名称数组
 *  @param iconImage          页码正常图
 *  @param selectedIconImage  页码选中图
 */
+(void)loadGuideViewToView:(UIWindow*)applicationWindown imageArr:(NSArray*)imageArr pageIconImage:(UIImage*)iconImage pageSelectedIconImage:(UIImage*)selectedIconImage;


/**
 *   按钮变为icon 在上，文字在下
 *
 *  @param button 按钮
 */
+ (void)relayoutBtnForVerticalLayout:(UIButton *)button;

/**
 *  缓存大小换算
 *
 *  @param cacheNumber 缓存子节
 *
 *  @return 显示大小
 */
+ (NSString *)cacheNumber:(int)cacheNumber;
@end
