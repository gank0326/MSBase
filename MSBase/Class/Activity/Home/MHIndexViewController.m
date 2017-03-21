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
#import "ELHomeHotCell.h"

@interface MHIndexViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;//列表
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
    [self.view addSubview:self.collectionView];
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
        _headView  = [[UIView alloc] initWithFrame:CGRectMake(0, 130, self.view.width, 120)];
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

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame)+5, self.view.width, self.view.height-255-64-49) collectionViewLayout:layout];
        layout.itemSize = [ELHomeHotCell itemSizeForCollectionView:CGSizeMake(self.view.width, self.view.height-255-64-49)];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ELHomeHotCell class] forCellWithReuseIdentifier:@"myCell"];
    }
    return _collectionView;
}
#pragma mark collection
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

//    NSDictionary *item = self.userList[(NSUInteger) indexPath.row];
    ELHomeHotCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
//    [cell updateWithDataItemDetail:item];
    return cell;
}

#pragma mark - UICollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}




@end
