//
//  MHIndexViewController.m
//  MSBase
//
//  Created by ganshunwei on 17/3/21.
//  Copyright © 2017年 ganshunwei. All rights reserved.
//

#import "MHIndexViewController.h"
#import "SDCycleScrollView.h"
#import "JCServiceView.h"

@interface MHIndexViewController ()

@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) UIView *headView;

@end

@implementation MHIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)customView {
    [super customView];
    [self.view addSubview:self.bannerView];
    [self.view addSubview:self.headView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"健康内蒙古";
}

#pragma mark -getter
- (SDCycleScrollView *)bannerView {
    if (!_bannerView) {
        NSMutableArray *imageArr = [NSMutableArray new];
        [imageArr addObject:@"ad1.jpg"];
        _bannerView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 125)];
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//        _bannerView.delegate = self;
        _bannerView.autoScroll = NO;
        _bannerView.pageDotColor = [UIColor el_mainColor];
        _bannerView.autoScrollTimeInterval = 5.0;
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _bannerView.placeholderImage = [UIImage imageWithColor:[UIColor el_subTitleColor]];
        _bannerView.localizationImageNamesGroup = imageArr;
    }
    return _bannerView;
}

- (UIView *)headView {
    if (!_headView) {
        
        CGFloat btnW = (self.view.width-34-20*3)/4;
        _headView  = [[UIView alloc] initWithFrame:CGRectMake(0, 135, self.view.width, 120)];
        _headView.backgroundColor = [UIColor whiteColor];
        NSArray *categoryArr = @[@{@"icon":@"",@"name":@"知识库",@"typeid":@"1",@"pic":@"icon_yan.png"},
                                 @{@"icon":@"",@"name":@"控烟干预",@"typeid":@"2",@"pic":@"icon_bi.png"},
                                 @{@"icon":@"",@"name":@"科普信息",@"typeid":@"3",@"pic":@"icon_weizheng.png"},
                                 @{@"icon":@"",@"name":@"小工具",@"typeid":@"4",@"pic":@"icon_chaoshengdao.png"}
                                 ];
        for (int i=0; i<categoryArr.count; i++) {
            JCServiceView *view=[[JCServiceView alloc]initWithFrame:CGRectMake(17+(btnW+20)*i, 0, btnW, btnW)];
            view.tag=4000+i;
            [view fillData:[categoryArr objectAtIndex:i]];
            [_headView addSubview:view];
        }
    }
    return _headView;
}

@end
