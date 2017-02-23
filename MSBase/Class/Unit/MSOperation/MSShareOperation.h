//
//  MSShareOperation.h
//  MSBase
//
//  Created by ganshunwei on 17/2/23.
//  Copyright © 2017年 ganshunwei. All rights reserved.
//

#import "MSOperation.h"

typedef NS_ENUM(NSInteger, MSShareResourceType) {
    MSShareResourceTypeImage,     //图片类型
    MSShareResourceTypeWeb,       //网页类型
};

typedef void (^MSShareCompletion)(UMSocialResponseEntity *shareResponse, DataItemDetail *detail);     //分享结束
typedef void (^MSRewardSuccessCallBack)(DataItemResult *result);

@interface MSShareOperation : MSOperation

@property (nonatomic, strong) DataItemDetail *liveInfo;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) UIImage *imgScreenshot;
@property (nonatomic, copy) MSShareCompletion shareCompletion;

@end
