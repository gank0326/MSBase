//
//  ELH5ErrorView.h
//  EMLive
//
//  Created by menglingchao on 16/11/16.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELH5ErrorView : UIView

/*!按钮回调*/
@property (nonatomic,copy) dispatch_block_t buttonBlock;

/*!加载到哪个视图上*/
- (void)showInView:(UIView *)view;

@end
