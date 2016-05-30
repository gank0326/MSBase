//
//  MSViewController.m
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSViewController.h"

@interface MSViewController ()

@end

@implementation MSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回上一级
- (void)sbCtrlPopNav:(id)sender {
    [self sb_colseCtrl];
}

@end
