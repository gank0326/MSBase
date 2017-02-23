//
//  MSLoginViewController.m
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSLoginViewController.h"
#import "MSShareController.h"

@implementation MSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self performSelector:@selector(jump) withObject:nil afterDelay:3.0];
}

- (void)jump {
//    DataItemDetail *dataDetail = [DataItemDetail new];
//    [self sb_openCtrl:el_actionurl_test(dataDetail,@"123")];
    [self doShareLive:[UIImage new]];
}

- (void)doShareLive:(UIImage *)shotImage {
    WS(weakSelf);
    MSShareController *sCtrl = [[MSShareController alloc] init];
//    [self.liveData setObject:[self.liveFloatView.headView fecthAvatarImage] forKey:@"avatar"];
    sCtrl.itemDetail = [DataItemDetail new];
    sCtrl.imgScreenshot = shotImage;
    sCtrl.doShare = ^(UIButton *button) {
//        if ([weakSelf isPushCtrl]) {
//            [weakSelf pushLive_shareLive:button.tag];
//        }
//        else if ([weakSelf isLiveCtrl]) {
//            if (shotImage) {
//                [weakSelf watchLive_screenShotShare];
//            }
//            else {
//                [weakSelf watchLive_shareLive:button.tag];
//            }
//        }
//        else if ([weakSelf isRecordCtrl]) {
//            [weakSelf watchRecord_shareLive:button.tag];
//        }
//        weakSelf.shareOpertion = [[ELShareOperation alloc] init];
//        weakSelf.shareOpertion.liveInfo = weakSelf.liveData;
//        weakSelf.shareOpertion.tag = button.tag;
//        weakSelf.shareOpertion.imgScreenshot = shotImage;
//        weakSelf.shareOpertion.shareCompletion = ^(UMSocialResponseEntity *shareResponse, DataItemDetail *detail) {
//            if (shareResponse.responseCode == 200 && !shotImage) {
//                [weakSelf shareSuccessCallBack:detail];
//                if ([weakSelf isPushCtrl]) {
//                    [weakSelf pushLive_shareSuccessCallBack:detail];
//                }
//                else if ([weakSelf isLiveCtrl]) {
//                    [weakSelf watchLive_shareSuccessCallBack:detail];
//                }
//                else if ([weakSelf isRecordCtrl]) {
//                    [weakSelf watchRecord_shareSuccessCallBack:detail];
//                }
//            }
//            weakSelf.shareOpertion = nil;//加了这句shareOpertion才会dealloc
//        };
//        [weakSelf.operationQueue addOperation:weakSelf.shareOpertion];
    };
    [self el_presentShare:sCtrl completion:nil];
}

@end
