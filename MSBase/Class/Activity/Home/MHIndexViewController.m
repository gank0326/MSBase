//
//  MHIndexViewController.m
//  MSBase
//
//  Created by ganshunwei on 17/3/21.
//  Copyright © 2017年 ganshunwei. All rights reserved.
//

#import "MHIndexViewController.h"
#import "SDCycleScrollView.h"

@interface MHIndexViewController ()

@property (nonatomic, strong) SDCycleScrollView *bannerView;

@end

@implementation MHIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)customView {
    [super customView];
    [self.view addSubview:self.bannerView];
    
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

@end
