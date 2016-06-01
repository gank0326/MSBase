//
//  MSHelper+UIBarButtonItem.h
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSHelper.h"

@interface MSHelper (UIBarButtonItem)

+ (UIBarButtonItem *)getLeftUIBarBtnItemWithTarget:(id)target withSEL:(SEL)sel;

+ (UIBarButtonItem *)getNavBtnNormal:(UIImage *)normalImageName hightlighit:(UIImage *)hImage
                          withTarget:(id)target withSEL:(SEL)sel;

+ (UIBarButtonItem *)getNavBtnWithImage:(UIImage *)icon
                             withTarget:(id)target withSEL:(SEL)sel;

+ (UIBarButtonItem *)getConfirmBtnItemWithTarget:(id)target withSEL:(SEL)sel;

+ (UIBarButtonItem *)getTextItemWithTarget:(NSString *)title forTarget:(id)target withSEL:(SEL)sel;

+ (UIBarButtonItem *)getLeftTextItemWithTarget:(NSString *)title forTarget:(id)target withSEL:(SEL)sel;

+ (UIBarButtonItem *)getNavBtn:(NSString *)imageName
                    withTarget:(id)target withSEL:(SEL)sel;

+ (UIBarButtonItem *)getRightUIBarBtnItemWithImage:(UIImage *)image
                                        withTarget:(id)target withSEL:(SEL)sel;

@end
