//
//  MSViewController.m
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSViewController.h"

@interface MSViewController ()
{
    BOOL viewDidloadCalled; //标志是不是已经call 了viewdidload
    UIView *rootView;
    UIBarButtonItem *leftButtonItem;
    UIBarButtonItem *rightButtonItem;
}
@property (nonatomic,strong)UIView *titleView;

@end

@implementation MSViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animating = NO;
    self.isAppear = NO;
    viewDidloadCalled = YES;
    self.autoCreateBackButtonItem = YES;
    self.view.backgroundColor = RGB_A(241, 241, 241, 1.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setTitleView:(UIView *)titleView_{
    _titleView = titleView_;
    if (self.isAppear) {
        self.navigationItem.titleView = self.titleView;
    }
}

- (void)setNavLeftBarButtonItem:(UIBarButtonItem *)item {
    if (self.isAppear) {
        self.navigationItem.leftBarButtonItem = item;
    }
    leftButtonItem = item;
}

- (UIBarButtonItem *)currentLeftUIBarButtonItem {
    return leftButtonItem;
}

- (void)setNavRightBarButtonItem:(UIBarButtonItem *)item {
    if (self.isAppear) {
        self.navigationItem.rightBarButtonItem = item;
    }
    rightButtonItem = item;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    if (title) {
        _titleView = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
    if (self.navigationController && self.autoCreateBackButtonItem && !self.navigationItem.leftBarButtonItem) {
        UIBarButtonItem *item = [MSHelper getLeftUIBarBtnItemWithTarget:self withSEL:@selector(popupMyself)];
        self.navigationItem.leftBarButtonItem = item;
        leftButtonItem = item;
    }
    [self resetNav];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.animating = NO;
    self.isAppear = YES;
    [self resetNav];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isAppear = NO;
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.animating = NO;
}

- (void)resetNav {
    if (self.titleView) {
        self.navigationItem.titleView = self.titleView;
    }
    if (rightButtonItem) {
        self.navigationItem.rightBarButtonItem = rightButtonItem;
    }
    if (leftButtonItem) {
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    }
}



- (void)dealloc {
    
}

- (void)willPopupFromNavigation {
    if (viewDidloadCalled) {
        [self removeScrollViewDelegate:self.view];
    }
}

-(void)removeScrollViewDelegate:(UIView *)subView
{
    if ([subView isKindOfClass:[UIScrollView class]]) {
        UIScrollView *tableView = (UIScrollView *)subView;
        tableView.delegate = nil;
    }
    if (subView.subviews.count > 0) {
        for (UIView *subViews in subView.subviews) {
            [self removeScrollViewDelegate:subViews];
        }
    }
}

//返回上一级
- (void)popupMyself {
    [self sb_colseCtrl];
}

@end
