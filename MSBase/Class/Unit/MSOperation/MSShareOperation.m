//
//  MSShareOperation.m
//  MSBase
//
//  Created by ganshunwei on 17/2/23.
//  Copyright © 2017年 ganshunwei. All rights reserved.
//

#import "MSShareOperation.h"

@interface MSShareOperation ()

@end


@implementation MSShareOperation

-(void)dealloc {
    
}
//开始
- (void)start {
    [super start];
    
    if (self.isCancelled) {
        self.state = MSOperationStateFinished;
        return;
    }
    
    void (^startBlock)() = ^void(){
        [self doShare];
    };
    
    //确保在主线程
    if ([NSThread currentThread] != [NSThread mainThread]) {
        dispatch_sync(dispatch_get_main_queue(), startBlock);
        
    }else{
        startBlock();
    }
}

//分享
- (void)doShare {
    UIImage *shareImage = nil;
    MSShareResourceType resourceType = 0;
    if (self.imgScreenshot) { //分享截图
        shareImage = self.imgScreenshot;
        resourceType = MSShareResourceTypeImage;
    } else { //分享网页
        resourceType = MSShareResourceTypeWeb;
    }
    NSString *shareURL = [self.liveInfo getString:@"url"];
    NSString *shareTitle = [self.liveInfo getString:@"title"];
    NSString *shareIntro = [self.liveInfo getString:@"intro"];
    SBWS(weakSelf);
    //分享
    [self doShare:self.tag resourceType:resourceType shareImage:shareImage shareURL:shareURL shareTitle:shareTitle shareIntro:shareIntro completion:^(UMSocialResponseEntity *shareResponse, DataItemDetail *detail) {
        [detail setObject:@"0" forKey:@"1"];//0-分享频道，1-分享活动
        [detail setObject:shareURL forKey:@"shareUrl"];
        
        if (weakSelf.shareCompletion) {
            weakSelf.shareCompletion(shareResponse, detail);
        }
        weakSelf.state = MSOperationStateFinished;
    }];
}

/** 分享 0 微信 1微信朋友圈  2微博 3qq */
- (void)doShare:(NSInteger)type resourceType:(MSShareResourceType)resourceType shareImage:(UIImage *)shareImage shareURL:(NSString *)shareURL shareTitle:(NSString *)shareTitle  shareIntro:(NSString *)shareIntro completion:(MSShareCompletion)completion {
    NSString *title = SBAppDisplayName;
    shareURL = shareURL.length > 0 ? shareURL : @"http://www.baidu.com";
    shareTitle = shareTitle.length > 0 ? shareTitle : [NSString stringWithFormat:@"我是标题%@颠倒众生", title];
    shareIntro = shareIntro.length > 0 ? shareIntro : [NSString stringWithFormat:@"我正在%@，下载APP！",title];
    
    if (type == 0) {
        [self shareToWXTimeline:shareImage shareURL:shareURL shareTitle:shareTitle shareIntro:shareIntro resourceType:resourceType completion:completion];
    }
    else if (type == 1) {
        [self shareToWX:shareImage shareURL:shareURL shareTitle:shareTitle shareIntro:shareIntro resourceType:resourceType completion:completion];
    }
    else if (type == 2) {
        [self shareToWeibo:shareImage shareURL:shareURL shareTitle:shareTitle shareIntro:shareIntro resourceType:resourceType completion:completion];
    }
    else if (type == 3) {
        [self shareToQQ:shareImage shareURL:shareURL shareTitle:shareTitle shareIntro:shareIntro resourceType:resourceType completion:completion];
    }
}

- (void)shareToWX:(UIImage *)shareImage shareURL:(NSString *)shareURL shareTitle:(NSString *)shareTitle shareIntro:(NSString *)shareIntro resourceType:(MSShareResourceType)resourceType completion:(MSShareCompletion)completion {
    [UMSocialData defaultData].extConfig.title = shareTitle;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = shareIntro;
    
    UMSocialUrlResourceType urlResourceType;
    
    if (resourceType == MSShareResourceTypeImage) {
        urlResourceType = UMSocialUrlResourceTypeImage;
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    } else {
        urlResourceType = UMSocialUrlResourceTypeWeb;
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    }
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareURL;
    [UMSocialData defaultData].shareImage = shareImage;
    
    
    
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:urlResourceType url:
                                        shareURL];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:shareIntro image:shareImage location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *shareResponse){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kELURLFromAppWXNotification" object:nil];
        if (completion) {
            //shareId,type 在业务那获取，这里不做透传
            NSDictionary *dic = @{@"targetplat":@"0"};
            DataItemDetail *detail = [DataItemDetail detailFromDictionary:dic];
            completion(shareResponse,detail);
        }
    }];
}

- (void)shareToWXTimeline:(UIImage *)shareImage shareURL:(NSString *)shareURL shareTitle:(NSString *)shareTitle shareIntro:(NSString *)shareIntro resourceType:(MSShareResourceType)resourceType completion:(MSShareCompletion)completion{
    
    NSString *shareString = [NSString stringWithFormat:@"%@ %@",shareTitle,shareIntro];
    [UMSocialData defaultData].extConfig.title = shareString;
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = shareString;
    
    UMSocialUrlResourceType urlResourceType;
    
    if (resourceType == MSShareResourceTypeImage) {
        urlResourceType = UMSocialUrlResourceTypeImage;
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    } else {
        urlResourceType = UMSocialUrlResourceTypeWeb;
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    }
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareURL;
    [UMSocialData defaultData].shareImage = shareImage;
    
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:urlResourceType url:
                                        shareURL];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:shareString image:shareImage location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *shareResponse){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kELURLFromAppWXNotification" object:nil];
        if (completion) {
            //shareId,type 在业务那获取，这里不做透传
            NSDictionary *dic = @{@"targetplat":@"1"};
            DataItemDetail *detail = [DataItemDetail detailFromDictionary:dic];
            completion(shareResponse,detail);
        }
    }];
}

/** 分享到微博 */
- (void)shareToWeibo:(UIImage *)shareImage shareURL:(NSString *)shareURL shareTitle:(NSString *)shareTitle shareIntro:(NSString *)shareIntro resourceType:(MSShareResourceType)resourceType completion:(MSShareCompletion)completion{
    
    NSString *shareText = [NSString stringWithFormat:@"%@ %@ %@",shareTitle,shareIntro,shareURL];
    if (resourceType == MSShareResourceTypeImage) {
        shareURL = @"";
        shareTitle = @"";
        shareIntro = @"";
        shareText = @"";
    }
    
    [UMSocialData defaultData].extConfig.title = shareTitle;
    [UMSocialData defaultData].extConfig.sinaData.shareText = shareText;
    [UMSocialData defaultData].shareImage = shareImage;
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                        shareURL];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:shareIntro image:shareImage location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *shareResponse){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kELURLFromAppSinaNotification" object:nil];
        if (completion) {
            //shareId,type 在业务那获取，这里不做透传
            NSDictionary *dic = @{@"targetplat":@"2"};
            DataItemDetail *detail = [DataItemDetail detailFromDictionary:dic];
            completion(shareResponse,detail);
        }
    }];
}

/** 分享到qq */
- (void)shareToQQ:(UIImage *)shareImage shareURL:(NSString *)shareURL shareTitle:(NSString *)shareTitle shareIntro:(NSString *)shareIntro resourceType:(MSShareResourceType)resourceType completion:(MSShareCompletion)completion{
    
    if (resourceType == MSShareResourceTypeImage) {
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
        shareURL = nil;
        shareTitle = nil;
        shareIntro = nil;
    } else {
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
    }
    
    [UMSocialData defaultData].extConfig.title = shareTitle;
    [UMSocialData defaultData].extConfig.qqData.url = shareURL;
    [UMSocialData defaultData].extConfig.qqData.shareText = shareIntro;
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:
                                        shareURL];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:shareIntro image:shareImage location:nil urlResource:urlResource presentedController:nil completion:^(UMSocialResponseEntity *shareResponse){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kELURLFromAppQQNotification" object:nil];
        if (completion) {
            //shareId,type 在业务那获取，这里不做透传
            NSDictionary *dic = @{@"targetplat":@"3"};
            DataItemDetail *detail = [DataItemDetail detailFromDictionary:dic];
            completion(shareResponse,detail);
        }
    }];
}


@end
