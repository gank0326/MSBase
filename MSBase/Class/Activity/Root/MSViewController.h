//
//  MSViewController.h
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSViewController : UIViewController

/** 返回上一级 (已经实现，有特殊要求可以重写)*/
- (void)sbCtrlPopNav:(id)sender;

@end
