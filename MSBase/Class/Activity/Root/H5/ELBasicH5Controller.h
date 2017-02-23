//
//  ELBasicH5Controller.h
//  EMLive
//
//  Created by roronoa on 16/5/10.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "MSViewController.h"
#import "UIViewController+H5Jump.h"
#import <WebKit/WebKit.h>

@interface ELBasicH5Controller : MSViewController <WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *h5View;//web
@property (nonatomic, strong) UILabel *company;//公司
@property (nonatomic, strong) NSString *navTitle;
@property (nonatomic, strong) NSURL *h5URL;

//加载  通过这个函数 开启h5
- (void)loadURL:(NSURL *)h5URL;

/**定义一开始的导航样式*/
- (void)navDidLoad;
/**根据网页是否能goback，改变导航栏左边样式*/
- (void)updateLeftNavItems;
/**根据网页的请求参数，使导航右侧显示分享按钮*/
- (void)doShare:(id)sender;
/**分享事件*/
- (void)shareBtnClick;
/**子类重写使用，去掉导航右侧分享按钮*/
- (void)hideRightBarButtonItem;
/**让网页goback*/
- (void)gobackH5:(id)sender;
/**关闭网页*/
- (void)closeH5:(id)sender;
/**根据网页的请求参数，决定如何跳转*/
- (BOOL)doH5Jump:(NSDictionary *)dic params:(NSString *)params;

@end
