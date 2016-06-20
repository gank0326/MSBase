//
//  MSUtil.h
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

struct SLSuitableRectInput {
    CGFloat totalWidth;
    CGFloat suggestWidth;
    CGFloat gap;
};

typedef struct SLSuitableRectInput SLSuitableRectInput;

struct SLSuitableRectOutput {
    CGFloat suitableWidth;
    int count;
};

typedef struct SLSuitableRectOutput SLSuitableRectOutput;

CG_INLINE SLSuitableRectOutput SLSuitableRectOutputMake(CGFloat width, CGFloat count)
{
    struct SLSuitableRectOutput rect;
    rect.suitableWidth = width; rect.count = count;
    return rect;
}

CG_INLINE SLSuitableRectInput SLSuitableRectInputMake(CGFloat totalWidth, CGFloat suggestWidth, CGFloat gap)
{
    struct SLSuitableRectInput rect;
    rect.totalWidth = totalWidth; rect.suggestWidth = suggestWidth;
    rect.gap = gap;
    return rect;
}

@interface MSUtil : NSObject

/**
 *  返回一个适合 input 条件的 output，output会指定个数与宽度
 *
 *  @param input 适合的宽度，总宽度，间隙
 *
 *  @return 推荐能够展示个数与宽度
 */
+ (SLSuitableRectOutput)suitableCountFitRect:(SLSuitableRectInput)input;

/**
 *  直播点亮动画
 *
 *  @param viewController 父view
 *  @param postion     点亮位置
 */
+ (void)addInfinityLoveEffectInView:(UIView *)view fromPostion:(CGPoint)postion type:(NSString *)type;

/**
 *  计算字符串大小
 *
 *  @param string   字符
 *  @param maxWidth 最大长度
 *  @param fontSize 字体大小
 *
 *  @return size
 */
+ (CGSize)sizeForString:(NSString *)string maxWidth:(CGFloat)maxWidth fontSize:(CGFloat)fontSize;

/**
 *  计算字符宽度
 *
 *  @param string 字符串
 *  @param font   字体大小
 *
 *  @return 宽度
 */
+ (CGFloat)widthForString:(NSString *)string fontSize:(CGFloat)fontSize;

/**
 *  绘制view圆角
 *
 *  @param view        view
 *  @param corners     那种圆角
 *  @param cornerRadii 角度
 */
+ (void)addCornerRadiusWith:(UIView *)view byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/**
 *  网络请求公共参数
 *
 *  @param body 原参数
 *
 *  @return 加上公共参数后的新参数
 */
+(NSMutableDictionary *)requestArgumentWithBody:(NSDictionary *)body;
@end
