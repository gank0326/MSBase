//
//  MSHelper.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSHelper.h"
#import "MSGuideView.h"

@implementation MSHelper

+ (void)relayoutBtnForVerticalLayout:(UIButton *)button {
    // the space between the image and text
    CGFloat spacing = 6.0;
    
    // lower the text and push it left so it appears centered
    //  below the image
    CGSize buttonSize = button.frame.size;
    CGSize imageSize = button.imageView.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0);
    
    // raise the image and push it right so it appears centered
    //  above the text
    CGSize titleSize = button.titleLabel.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), (buttonSize.width - imageSize.width) / 2, 0.0, (buttonSize.width - imageSize.width) / 2);
}

+(void)loadGuideViewToView:(UIWindow*)applicationWindown imageArr:(NSArray*)imageArr pageIconImage:(UIImage*)iconImage pageSelectedIconImage:(UIImage*)selectedIconImage
{
    NSString *shortVersionKey = [SBAppCoreInfo shortVersionString];
    NSInteger showWelcome = [[SBAppCoreInfo getCoreDB] getIntValue:kShowWelcomePage dataKey:shortVersionKey];
    if (showWelcome != 1)
    {
        MSGuideView *guideView = [[MSGuideView alloc]initWithFrame:applicationWindown.frame];
        [guideView initSubviews:applicationWindown picArr:imageArr pageIcon:iconImage pageSelectedIcon:selectedIconImage];
    }
}

+ (NSString *)cacheNumber:(int)cacheNumber{
    if (cacheNumber <= 1024) {
        return [NSString stringWithFormat:@"%d B",cacheNumber];
    }else if (cacheNumber > 1024  && cacheNumber <= (1024 * 1024)){
        return [NSString stringWithFormat:@"%.1f KB",cacheNumber/1024 * 1.0];
    }else if(cacheNumber > (1024 * 1024) && cacheNumber < (1024 * 1024 *1024)){
        return [NSString stringWithFormat:@"%.1f M",cacheNumber/(1024.0*1024.0)*1.0];
    }else{
        return [NSString stringWithFormat:@"%.1f G",cacheNumber/(1024*1024*1024) *1.0];
    }
}
@end
