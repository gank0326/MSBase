//
//  MSUtil.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSUtil.h"

@implementation MSUtil

+ (SLSuitableRectOutput)suitableCountFitRect:(SLSuitableRectInput)input {
    int count = (input.totalWidth * 1.0f+2*input.gap) / (input.suggestWidth + input.gap);
    CGFloat suggestWidth = ((input.totalWidth * 1.0f) - (count - 1) * input.gap)/count;
    return SLSuitableRectOutputMake(suggestWidth, count);
}

+ (void)addInfinityLoveEffectInView:(UIView *)view fromPostion:(CGPoint)postion type:(NSString *)type
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"el_live_heart_%@", type]]];
    [view addSubview:imageView];
    CGFloat x = arc4random() % (20 + 1) - 20.0f + postion.x;
    CGFloat y = arc4random() % (20 + 1) - 20.0f + postion.y;
    [imageView setCenter:CGPointMake(x, y)];
    POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    [positionAnimation setToValue:@(200)];
    [positionAnimation setDuration:3.0f + arc4random() % 5];
    [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished)
     {
         [imageView removeFromSuperview];
     }];
    
    POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    [alphaAnimation setToValue:@(0)];
    [alphaAnimation setDuration:4.0];
    
    POPBasicAnimation *positionXAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    [positionXAnimation setToValue:@(imageView.layer.position.x + arc4random() % (15 + 1) - 15)];
    [positionXAnimation setAutoreverses:YES];
    [positionXAnimation setRepeatForever:YES];
    [positionXAnimation setDuration:1.5f + arc4random() % 1];
    
    [imageView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    [imageView pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
    [imageView.layer pop_addAnimation:positionXAnimation forKey:@"positionXAnimation"];
}

+ (CGSize)sizeForString:(NSString *)string maxWidth:(CGFloat)maxWidth fontSize:(CGFloat)fontSize
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}
                                       context:nil].size;
    return size;
}

+ (CGFloat)widthForString:(NSString *)string fontSize:(CGFloat)fontSize
{
    return [string sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}].width;
}

+ (void)addCornerRadiusWith:(UIView *)view byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    view.layer.masksToBounds = YES;
}

+(NSMutableDictionary *)requestArgumentWithBody:(NSDictionary *)body
{
    // 增加默认参数
    NSMutableDictionary *requestArgument= [[NSMutableDictionary alloc] initWithDictionary:body];
    requestArgument[@"platform"] = @"ios";
    requestArgument[@"sys_version"] = [[UIDevice currentDevice] systemVersion];
    requestArgument[@"soft_version"] = [MSAppCoreInfo shortVersionString];
    requestArgument[@"screen"] = [NSString stringWithFormat:@"%@*%@", @(SCREEN_WIDTH*2), @(SCREEN_HEIGHT*2)];
    //    requestArgument[@"signature"] = [JCViewUtil generateRequestSignature:requestArgument];
    return requestArgument;
}

@end
