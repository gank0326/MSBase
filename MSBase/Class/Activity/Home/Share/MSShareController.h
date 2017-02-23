//
//  MSShareController.h
//  MSBase
//
//  Created by ganshunwei on 17/2/23.
//  Copyright © 2017年 ganshunwei. All rights reserved.
//

#import "MSViewController.h"
#import "MSShareOperation.h"         //视频分享操作


#define ELShareControllerHeigth 184

/** 分享 **/
@interface MSShareController : MSViewController


@property (nonatomic ,strong) UIImage *imgScreenshot;//截屏图片
@property (nonatomic, strong) DataItemDetail *itemDetail;
@property (nonatomic, strong) NSArray *arrayItem;           //分享渠道类别

@property (nonatomic, copy) void (^doShare)(UIButton *button);//分享
@end



