//
//  MSLoginViewController.m
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSLoginViewController.h"

@implementation MSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self performSelector:@selector(jump) withObject:nil afterDelay:3.0];
}

- (void)jump {
    DataItemDetail *dataDetail = [DataItemDetail new];
    [self sb_openCtrl:el_actionurl_test(dataDetail,@"123")];
}

@end
