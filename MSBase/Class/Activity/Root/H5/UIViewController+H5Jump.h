//
//  UIViewController+H5Jump.h
//  EMLive
//
//  Created by menglingchao on 16/9/8.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import <UIKit/UIKit.h>

/**h5界面跳转*/
@interface UIViewController (H5Jump)

/**h5界面跳转*/
- (BOOL)el_doH5Jump:(NSDictionary *)dic;

/*!直接传h5逻辑里面的scheme进行跳转*/
- (BOOL)el_doH5JumpWithUrlString:(NSString *)urlString;

//路由跳转
- (BOOL)el_openURL:(NSString *)url;

@end
