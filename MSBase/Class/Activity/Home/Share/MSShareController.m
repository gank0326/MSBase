//
//  MSShareController.m
//  MSBase
//
//  Created by ganshunwei on 17/2/23.
//  Copyright © 2017年 ganshunwei. All rights reserved.
//

#import "MSShareController.h"

@interface MSShareController ()

@property (nonatomic, strong) UILabel *lbTips;  //提示文字//横线
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) NSOperationQueue *shareQueue;

@end

@implementation MSShareController

-(id)initWithItem:(NSArray *)array {
    self.arrayItem = array;
    self = [self init];
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.shareQueue cancelAllOperations];
}

-(void)customView {
    [super customView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    self.shareQueue = [[NSOperationQueue alloc] init];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    NSMutableArray *arrayBtn = [[NSMutableArray alloc] init];
    for (UIButton *btn in self.view.subviews) {
        if (btn.tag < 4) {
            [arrayBtn addObject:btn];
        }
    }
    
    //布局分享按钮
    CGFloat labelWidth = self.view.width/arrayBtn.count;
    for (NSInteger i = 0; i < arrayBtn.count; i++) {
        //按钮
        UIButton *btn = arrayBtn[i];
        btn.frame = CGRectMake(i*labelWidth, 24, labelWidth, 68);
        [btn sb_titleUnderIcon:8];
    }
    
    //提示文字
    self.lbTips.frame = CGRectMake(24, 110, self.view.width - 24*2, 24);
    
    //横线
    self.viewLine.frame = CGRectMake(24, self.view.height - 44, self.view.frame.size.width - 48, APPCONFIG_UNIT_LINE_WIDTH);
    
    self.btn.frame = CGRectMake(0, self.view.height - 44, self.view.width, 44);
}

//
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)initUI {
    
    //分享按钮及文字
    NSMutableArray *arrayName = [[NSMutableArray alloc] initWithObjects:@"微信朋友圈", @"微信好友", @"新浪微博", @"腾讯QQ", nil];
    NSMutableArray *arrayImg = [[NSMutableArray alloc] initWithObjects:@"el_icon_frame_share_circle", @"el_icon_frame_share_wechat", @"el_icon_frame_share_sina", @"el_icon_frame_share_qq", nil];
    NSMutableArray *arrayImgDisabled = [[NSMutableArray alloc] initWithObjects:@"el_icon_frame_share_circle_disable", @"el_icon_frame_share_wechat_disable", @"el_icon_frame_share_sina_disable", @"el_icon_frame_share_qq_disable", nil];
    
    if (self.arrayItem > 0) {
        //遍历所有渠道,缺哪个就从按钮数组去掉哪个
        if (![self.arrayItem containsObject:@"pengyouquan"]) {
            [arrayName removeObject:@"微信朋友圈"];
            [arrayImg removeObject:@"el_icon_frame_share_circle"];
            [arrayImgDisabled removeObject:@"el_icon_frame_share_circle_disable"];
        }
        if (![self.arrayItem containsObject:@"weixin"]) {
            [arrayName removeObject:@"微信好友"];
            [arrayImg removeObject:@"el_icon_frame_share_wechat"];
            [arrayImgDisabled removeObject:@"el_icon_frame_share_wechat_disable"];
        }
        if (![self.arrayItem containsObject:@"weibo"]) {
            [arrayName removeObject:@"新浪微博"];
            [arrayImg removeObject:@"el_icon_frame_share_sina"];
            [arrayImgDisabled removeObject:@"el_icon_frame_share_sina_disable"];
        }
        if (![self.arrayItem containsObject:@"qq"]) {
            [arrayName removeObject:@"腾讯QQ"];
            [arrayImg removeObject:@"el_icon_frame_share_qq"];
            [arrayImgDisabled removeObject:@"el_icon_frame_share_qq_disable"];
        }
        
    }
    
    NSInteger itemCount = arrayName.count;
    //生成分享button，并将安装了分享应用的分享button加入数组
    NSMutableArray *arrayBtn = [[NSMutableArray alloc] init];
    CGFloat btnW = 32;
    for (NSInteger i = 0; i < itemCount; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnW, btnW)];
        btn.backgroundColor = [UIColor clearColor];
        [btn setImage:[UIImage imageNamed:arrayImg[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:arrayImgDisabled[i]] forState:UIControlStateDisabled];
        [btn setTitle:arrayName[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        btn.tag = i;
        [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        
        //        if ([WXApi isWXAppInstalled] && i < 2) {
        //            [arrayBtn addObject:btn];
        //        } else if ([WeiboSDK isWeiboAppInstalled] && i == 2) {
        //            [arrayBtn addObject:btn];
        //        } else if ([QQApiInterface isQQInstalled] && i == 3) {
        //            [arrayBtn addObject:btn];
        //        }
        
        btn.enabled = NO;
        if ([WXApi isWXAppInstalled] && i < 2) {
            btn.enabled = YES;
        } else if ([WeiboSDK isWeiboAppInstalled] && i == 2) {
            btn.enabled = YES;
        } else if ([QQApiInterface isQQInstalled] && i == 3) {
            btn.enabled = YES;
        }
        [arrayBtn addObject:btn];
    }
    
    CGFloat labelWidth = self.view.width/arrayBtn.count;
    for (NSInteger i = 0; i < arrayBtn.count; i++) {
        //按钮
        UIButton *btn = arrayBtn[i];
        btn.frame = CGRectMake(i*labelWidth, 24, labelWidth, 68);
        [self.view addSubview:btn];
        [btn sb_titleUnderIcon:8];
    }
    
    //标题
    NSString *strTips = [self.itemDetail getString:@"shared_describe"];
    
    _lbTips = [[UILabel alloc] init];
    _lbTips.tag = 4;
    _lbTips.backgroundColor = [UIColor clearColor];
    _lbTips.font = [UIFont systemFontOfSize:12];
    _lbTips.textColor = [UIColor yellowColor];
    _lbTips.textAlignment = NSTextAlignmentLeft;
    self.lbTips.text = strTips;
    [self.view addSubview:_lbTips];
    
    //横线
    self.viewLine = [[UIView alloc] init];
    self.viewLine.tag = 5;
    self.viewLine.backgroundColor = [UIColor el_lineColor];
    [self.view addSubview:self.viewLine];
    
    //取消按钮
    self.btn = [[UIButton alloc] init];
    self.btn.tag = 6;
    self.btn.backgroundColor = [UIColor clearColor];
    [self.btn addTarget:self action:@selector(dismissShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setTitleColor:RGB_HEX(0x333333) forState:UIControlStateNormal];
    [self.btn setTitle:@"取 消" forState:UIControlStateNormal];
    self.btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.btn];
}

//选择某个分享
-(void)share:(UIButton *)button {
    if (self.doShare) {
        self.doShare(button);
        [self dismissShare:nil];
    }
}

- (void)dismissShare:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
