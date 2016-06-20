//
//  TestViewController.m
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "TestViewController.h"

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    [self performSelector:@selector(AAA) withObject:nil afterDelay:5.0];
}

- (void)AAA {
    
    MSRequest *loginRequest =  [MSHttpProcess ms_loginmobile:@"15221654182" password:@"111111"];
    [loginRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        NSLog(@"%@",[request responseJSONObject]);
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
        NSLog(@"%@",[request responseJSONObject]);
    }];
}

@end
