//
//  ELBasicH5Controller.m
//  EMLive
//
//  Created by roronoa on 16/5/10.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "ELBasicH5Controller.h"
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIViewController+ELPresent.h"     //弹窗
#import "MSShareController.h"       //分享
#import "ELH5ErrorView.h"
#import "NJKWebViewProgressView.h"
//#import "ELUploadProcess.h"
//#import "ELImagePicker.h"

@interface ELBasicH5Controller ()
/**网页顶部加载进度条*/
@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@property (nonatomic, strong) UIImageView *shareImg;     //用于分享图片下载的下载器
@property (nonatomic, copy) NSString *shareCallBackName; //分享结束回调函数名
@property (nonatomic, strong) NSDictionary *photoDic; //拍照上传用dic
@property (nonatomic, strong) MSShareOperation *shareOpertion;
@property (nonatomic, strong) NSOperationQueue *operationQueue;//操作集合
//@property (nonatomic, strong) ELImagePicker *imagePicker;
//@property (nonatomic, strong) ELDataTaskOperation *uploadOperation;
//@property (nonatomic, strong) ELDataTaskOperation *logOperation;
@end

@implementation ELBasicH5Controller {
    BOOL _hasObservedKVO;//监听了KVO通知
}

#pragma mark - Overvide
- (void)dealloc {
    [SBNotificationCenter removeObserver:self];
    if (_hasObservedKVO) {
        [self removeObserver:self forKeyPath:@"h5View.title"];
        [self removeObserver:self forKeyPath:@"h5View.estimatedProgress"];
        [self removeObserver:self forKeyPath:@"h5View.canGoBack"];
    }
//    [self.uploadOperation stopTask];
//    [self.logOperation stopTask];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customView];
}

- (void)customView {
    self.operationQueue = [[NSOperationQueue alloc] init];
    [self navDidLoad];
    [self h5View];
    [self progressView];
    [self loadURL:self.h5URL];
    //监听分享结束通知，用于js回调
    [SBNotificationCenter addObserver:self selector:@selector(shareDidFinish:) name:@"kELURLFromAppWXNotification" object:nil];
    [SBNotificationCenter addObserver:self selector:@selector(shareDidFinish:) name:@"kELURLFromAppSinaNotification" object:nil];
    [SBNotificationCenter addObserver:self selector:@selector(shareDidFinish:) name:@"kELURLFromAppQQNotification" object:nil];
    //    [SBApplication aspect_hookSelector:@selector(openURL:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
    //
    //    } error:nil];
}

- (void)navDidLoad {
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    if (self.navTitle.length > 0) {
    //        self.navigationItem.title = self.navTitle;
    //    }
    [self updateLeftNavItems];
}

- (void)updateLeftNavItems {
    if (self.h5View.canGoBack) {
        //控制导航栏左上角的返回和关闭按钮的显示
        UIBarButtonItem *backItem = [UIBarButtonItem el_itemImage:[UIImage imageNamed:@"el_btn_back"]
                                                            title:@"返回"
                                                      titleInsets:UIEdgeInsetsMake(0, 2, 0, -2)
                                                           target:self
                                                           action:@selector(gobackH5:)];
        backItem.tag = elNavBackBtnTag;
        UIBarButtonItem *colseItem = [UIBarButtonItem el_titleBtnItem:@"关闭" target:self action:@selector(closeH5:)];
        self.navigationItem.leftBarButtonItems = @[backItem, colseItem];
    } else {
        UIBarButtonItem *backItem = [UIBarButtonItem el_itemImage:[UIImage imageNamed:@"el_btn_back"]
                                                            title:@"返回"
                                                      titleInsets:UIEdgeInsetsMake(0, 2, 0, -2)
                                                           target:self
                                                           action:@selector(gobackH5:)];
        backItem.tag = elNavBackBtnTag;
        self.navigationItem.leftBarButtonItems = @[backItem];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark -
- (WKWebView *)h5View {
    if (! _h5View) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
        configuration.allowsInlineMediaPlayback = NO;// iPad上为YES，需要设置为NO
        _h5View = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _h5View.backgroundColor = RGB(0x2e, 0x31, 0x32);
//        _h5View.scalesPageToFit = YES;
//        _h5View.multipleTouchEnabled = YES;
        _h5View.allowsBackForwardNavigationGestures = YES;
        _h5View.navigationDelegate = self;
        _h5View.UIDelegate = self;
        [self addObserver:self forKeyPath:@"h5View.title" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"h5View.estimatedProgress" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"h5View.canGoBack" options:(NSKeyValueObservingOptionNew) context:nil];
        _hasObservedKVO = YES;
        [self.view addSubview:_h5View];
        [_h5View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _h5View;
}

- (NJKWebViewProgressView *)progressView {
    if (! _progressView) {
        _progressView = [[NJKWebViewProgressView alloc]init];
        _progressView.progressBarView.backgroundColor = [UIColor el_mainColor];
        _progressView.progressBarView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.h5View addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.h5View);
            make.height.mas_equalTo(2);
        }];
    }
    return _progressView;
}

#pragma mark - Event
- (void)gobackH5:(id)sender {
//    NSString *result = [self.h5View stringByEvaluatingJavaScriptFromString:@"goBack()"];
    [self.h5View evaluateJavaScript:@"goBack()" completionHandler:^(id _Nullable object, NSError * _Nullable error) {
//        if (result && result.length > 0) {
//            return;
//        }
        if (self.h5View.canGoBack) {
            [self.h5View goBack];
        } else {
            [self closeH5:nil];
        }
    }];
}

- (void)closeH5:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
//js返回json标准格式（h5那边给的格式）
- (NSString *)commonJSFormatCallBack:(NSString *)isSuccess data:(NSString *)data msg:(NSString *)msg {
    //{\"code\":\"%@\",\"data\":\"%@\",\"msg\":\"%@\"}
    NSString *commonStr = [NSString stringWithFormat:@"{\"code\":\"%@\",\"data\":%@,\"msg\":\"%@\"}", isSuccess, data, msg];
    return commonStr;
}

- (NSString *)h5GetUniqueId {
    return @"1123";//[ELPspHttpLoader emIdfv];
}

- (void)h5GetUserInfo:(NSDictionary *)dic {
//    if (dic[@"callbackname"]) {
//        NSString *ctoken = [ELUserInfoUnit getCToken];
//        NSString *utoken = [ELUserInfoUnit getUToken];
//        NSString *uid = [ELUserInfoUnit getUserID];      //2016-12-7 version 1.5.1 传 userid 不再传pi
//        
//        NSString *dataStr = [NSString stringWithFormat:@"{\"ct\":\"%@\",\"ut\":\"%@\",\"uid\":\"%@\"}", ctoken,utoken, uid];
//        NSString *commonBackStr = [self commonJSFormatCallBack:@"0" data:dataStr msg:@""];
//        NSString *weixinauthJson = [NSString stringWithFormat:@"%@('%@')",dic[@"callbackname"], commonBackStr];
//        
//        [self.h5View evaluateJavaScript:weixinauthJson completionHandler:nil];
//    }
}

- (void)h5GetDeviceInfo:(NSDictionary *)dic {
//    if (dic[@"callbackname"]) {
//        //
//        NSString *uniqueId = [self h5GetUniqueId];      //用户唯一识别
//        NSString *productType = EL3rdConfig(@"appType");      //用户产品类型
//        NSString *appVersion = SBAppVersion;      //用户产品版本信息
//        NSString *deviceType =   [SBAppCoreInfo sharedSBAppCoreInfo].clientOS;      //用户设备类型
//        NSString *deviceModel = [SBAppCoreInfo sharedSBAppCoreInfo].clientMachine;      //用户设备型号
//        //加手机号
//        NSString *phonenumber = @"13888888888";
//        NSString *network = ELGetNetworkReachabilityState();
//        
//        NSString *dataStr = [NSString stringWithFormat:@"{\"Sys\":\"ios\",\"ProductType\":\"%@\",\"Version\":\"%@\",\"DeviceType\":\"%@\",\"DeviceModel\":\"%@\",\"mobile\":\"%@\",\"UniqueID\":\"%@\",\"network\":\"%@\",\"plat\":\"%@\"}", productType,appVersion,deviceType,deviceModel,phonenumber,uniqueId,network, @"Iphone"];
//        NSString *commonBackStr = [self commonJSFormatCallBack:@"0" data:dataStr msg:@""];
//        NSString *weixinauthJson = [NSString stringWithFormat:@"%@('%@')",dic[@"callbackname"], commonBackStr];
//        
//        [self.h5View evaluateJavaScript:weixinauthJson completionHandler:nil];
//    }
}

//加载
- (void)loadURL:(NSURL *)h5URL {
    self.h5URL = h5URL;
    NSURLRequestCachePolicy policy = NSURLRequestUseProtocolCachePolicy;// 默认使用缓存
//    if ([SBUserDefaults integerForKey:DEBUG_WEBVIEW_CACHEPLICY] == 1) {
//        policy = NSURLRequestReloadIgnoringLocalCacheData;
//    }
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:h5URL cachePolicy:policy timeoutInterval:60];
    [req addValue:@"EastMoneyAPP iOS" forHTTPHeaderField:@"EMUA"];
    [self.h5View loadRequest:req];
}

//定制导航栏－标题修改
- (void)h5ContrlNativeTitle:(NSDictionary *)dic {
    if (dic.count == 1) {
        //单行标题
        [self setNavgationSingleTitle:dic[@"title1"]];
    }
}

- (BOOL)doH5Jump:(NSDictionary *)dic params:(NSString *)params {
    if ([self checkJumpToEMLive:dic params:params] == NO) { //检查是否要跳转从其他app跳转至emlive
        return [self el_doH5Jump:dic];
    }
    return NO;
}

- (BOOL)checkJumpToEMLive:(NSDictionary *)dic params:(NSString *)params {
    /*
     appname = "haitunlive://";
     callbackname = callbackOpen;
     scheme = "emlive://jinyuzhibo.com/home?page=home_live_concern";
     */
    NSString *appname = dic[@"appname"];
    if ([appname isEqualToString:@"haitunlive://"]) {
            //非本app检测到haitunlive，跳转到emlive
            NSString *jumpHeader = @"emlive://";
            if ([SBApplication canOpenURL:[NSURL URLWithString:jumpHeader]]) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.strings = @[jumpHeader,params];//通过剪切版传递跳转参数
                [SBApplication openURL:[NSURL URLWithString:jumpHeader]];
            } else {
                //callback to download emlive app
                NSString *callbackname = dic[@"callbackname"];
                NSString *successString = [NSString stringWithFormat:@"{\"code\":\"%@\"}", @"1"];
                NSString *jsString = [NSString stringWithFormat:@"%@('%@')",callbackname,successString];
                [self.h5View evaluateJavaScript:jsString completionHandler:nil];
            }
            return YES;
    }
    return NO;
}

- (void)doShare:(id)sender {
    BOOL isNeed = NO;
    if ([sender isKindOfClass:[NSString class]]) {
        isNeed = [(NSString *)sender integerValue] == 1 ? YES : NO;
    }
    
    if (isNeed) {
        UIBarButtonItem *rightItem = [UIBarButtonItem el_titleBtnItem:@"分享" target:self action:@selector(shareBtnClick)];
        self.navigationItem.rightBarButtonItem = rightItem;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

/**子类重写使用，去掉导航右侧分享按钮*/
- (void)hideRightBarButtonItem {
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)shareBtnClick {
    //让网页去调用分享逻辑
    [self.h5View evaluateJavaScript:@"emH5ShareInfo()" completionHandler:nil];
}

//js调用app分享
- (void)h5ContrlNativeShare:(NSDictionary *)dic {    
    NSString *type = dic[@"type"];
    NSArray *arrayType = [type componentsSeparatedByString:@","];
    MSShareController *sCtrl = [[MSShareController alloc] init];
    sCtrl.arrayItem = arrayType;
    [self el_presentShare:sCtrl completion:nil];
    
    SBWS(weakSelf)
    sCtrl.doShare = ^(UIButton *button) {
        [weakSelf shareLive:button.tag dic:dic url:weakSelf.h5View.URL.absoluteString];
    };
}

- (void)shareLive:(NSInteger)tag dic:(NSDictionary *)dic url:(NSString *)url {
    
    SBWS(weakSelf)
    self.shareCallBackName = [NSString stringWithFormat:@"%@()",dic[@"callbackname"]];
    
    NSString *imgUrl = dic[@"img"];
    
    self.shareImg = [[UIImageView alloc] init];
    
    //先图片下载
//    [self.shareImg el_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        DataItemDetail *info = [DataItemDetail new];
//        [info setString:dic[@"img"] forKey:ELLV_NODE_AVATAR_URL];
//        [info setString:dic[@"url"] forKey:ELLV_NODE_SHARED_URL];
//        [info setString:dic[@"title"] forKey:ELLV_NODE_SHARED_TITLE];
//        [info setString:dic[@"desc"] forKey:ELLV_NODE_SHARED_INTRO];
//        self.shareOpertion = [[ELShareOperation alloc] init];
//        self.shareOpertion.liveInfo = info;
//        self.shareOpertion.tag = tag;
//        self.shareOpertion.imgScreenshot = nil;
//        //    __block ELShareOperation *bShareOpertion = weakSelf.shareOpertion;
//        self.shareOpertion.shareCompletion = ^(UMSocialResponseEntity *shareResponse, DataItemDetail *detail) {
//            if (shareResponse.responseCode == 200) {
//                [weakSelf shareForClick:0 url:weakSelf.h5View.URL.absoluteString];//仅为打点
//            }
//            weakSelf.shareOpertion = nil;//加了这句shareOpertion才会dealloc。。注，其实operation把自己状态设为finished就行了，不需要外部释放
//            
//        };
//        
//        [self.operationQueue addOperation:self.shareOpertion];
//        
//    }];
}

- (void)doPaste:(NSDictionary *)dic {
    NSString *callbackname = dic[@"callbackname"];
    NSString *content = dic[@"content"];
    if (content.length > 0) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:content];
        
        NSString *successString = [NSString stringWithFormat:@"{\"code\":\"%@\"}", @"0"];
        NSString *jsString = [NSString stringWithFormat:@"%@('%@')",callbackname,successString];
        [self.h5View evaluateJavaScript:jsString completionHandler:nil];
    }
}

/**
 *  设置单行标题
 *  @param name 标题名称
 */
- (void)setNavgationSingleTitle:(NSString *)name{
    if (name.length) {
        self.navigationItem.title = name;
    }
}

- (void)shareDidFinish:(NSNotification *)notification {
    //分享结束
    [self.h5View evaluateJavaScript:self.shareCallBackName completionHandler:nil];
}

- (void)shareForClick:(NSInteger)type url:(NSString *)url {
    //用于打点统计传参
}

//上传log日志
- (void)uploadLog:(NSDictionary *)dic {
//    NSString *time = dic[@"time"];
//    self.logOperation = [ELUploadProcess el_suggest_uploadLogData:time success:^(NSData *data, NSURLResponse *response) {
//        NSLog(@"log upload success");
//    } failure:^(NSData *data, NSURLResponse *response) {
//        NSLog(@"log upload failure");
//    }];
}

#pragma mark - 上传图片相关
- (void)uploadPhoto:(NSDictionary *)dic {
//    /*
//     callbackname = callbackScreenShot;
//     url = "http://lvbqas.eastmoney.com:8001/LVBPages/Identify/Upload";
//     */
//    self.photoDic = dic;
//    BOOL isCrop = [dic[@"isCrop"] boolValue];
//    
//    SBWS(weakSelf)
//    [self el_actionSheetWithTitle:@"选取" cancelblock:nil];
//    [self el_addButtonWithTitle:@"拍照" block:^{
//        [weakSelf takeCamera:isCrop];
//    }];
//    [self el_addButtonWithTitle:@"相册" block:^{
//        [weakSelf takeAlbum:isCrop];
//    }];
//    [self el_presentSheetCompletion:nil];
    
}

//打开相机
- (void)takeCamera:(BOOL)isCrop {
//    SBWS(weakSelf)
//    [self.imagePicker pickImageFromCameraWithController:self allowsEditing:isCrop resultBlock:^(UIImage *image) {
//        [weakSelf doPhotoTask:image];
//    }];
}

//打开相册
- (void)takeAlbum:(BOOL)isCrop {
//    SBWS(weakSelf)
//    [self.imagePicker pickSingleImageWithController:self allowsEditing:isCrop resultBlock:^(UIImage *image) {
//        [weakSelf doPhotoTask:image];
//    }];
}

- (void)doPhotoTask:(UIImage *)pImage {
//    NSData *imageData = UIImageJPEGRepresentation(pImage,0.3);
//    NSString *uploadString = self.photoDic[@"url"];
//    if (uploadString == nil || uploadString.length == 0) {
//        uploadString = self.photoDic[@"uploadurl"];
//        if (uploadString == nil || uploadString.length == 0) {
//            [self.view sb_showTips:@"出错：上传图片地址为空" hiddenAfterSeconds:APPCONFIG_UI_TIPS_SHOW_SECONDS];
//            return;
//        }
//    }
//        
//    SBWS(weakSelf)
//    
//    self.uploadOperation = [ELUploadProcess el_uploadPhoto_inH5_url:uploadString imageData:imageData success:^(NSData *data, NSURLResponse *response) {
//        NSDictionary *responseDict = [data sb_objectFromJSONData];
//        NSString *imagePath = responseDict[@"path"];
//        
//        if (!(imagePath == nil || imagePath == NULL || [imagePath isKindOfClass:[NSNull class]])) {
//            [weakSelf sb_showTips:@"上传图片成功" hiddenAfterSeconds:APPCONFIG_UI_TIPS_SHOW_SECONDS];
//            [weakSelf uploadPhotoSuccess:responseDict image:pImage];
//        } else {
//            [weakSelf sb_showTips:@"上传图片失败" hiddenAfterSeconds:APPCONFIG_UI_TIPS_SHOW_SECONDS];
//        }
//    } failure:^(NSData *data, NSURLResponse *response) {
//        [weakSelf sb_showTips:@"上传图片失败" hiddenAfterSeconds:APPCONFIG_UI_TIPS_SHOW_SECONDS];
//    }];
//    [self sb_showTips:@"正在为您上传图片..."];
}

- (void)uploadPhotoSuccess:(NSDictionary *)dic image:(UIImage *)img {
    /* json格式
     {
     code:"0",//0代表成功
     path:"", //返回的图片地址
     serverpath:""//图片服务器地址
     }
     */
    
    /* 上传成功回调格式
     message = "";
     path = "20160722/852F667DD44CAA192FF1F08D93D6854F.png";
     result = 0;
     serverpath = "http://lvbqas.eastmoney.com:8002/Picture/";
     */
    UIImage *img1 = [img sb_scalingToAspectRatioForTargetWidth:375];
    NSData *imageData = UIImageJPEGRepresentation(img1,0.1);
    NSString *strImgBase64 = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString * jsonStr = @"";
    //字典转json字符串的方法，然而转成的字符串没卵用，只能用下面手工拼接了
    //第一层
    NSMutableDictionary *mDicBack = [NSMutableDictionary new];
    mDicBack[@"msg"] = @"success";
    mDicBack[@"code"] = @"0";
    //第二层
    NSMutableDictionary *mDic2 = [NSMutableDictionary new];
    mDic2[@"fromserver"] = dic;
    mDic2[@"base64"] = [NSString stringWithFormat:@"data:image/jpg;base64,%@",strImgBase64];
    
    mDicBack[@"data"] = mDic2;
    
    if ([NSJSONSerialization isValidJSONObject:mDicBack])
    {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:mDicBack options:NSJSONWritingPrettyPrinted error:nil];
        jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonStr = [NSString stringWithFormat:@"{\"msg\":\"success\",\"code\":\"0\",\"data\":{\"fromserver\":{\"result\":%@,\"message\":\"%@\",\"path\":\"%@\",\"serverpath\":\"\%@\"},\"base64\":\"data:image/png;base64,%@\"}}",dic[@"result"],dic[@"message"],dic[@"path"],dic[@"serverpath"],strImgBase64];
    
    NSString *callBack = self.photoDic[@"callbackname"];
    if (callBack.length == 0 || callBack == nil) {
        callBack = self.photoDic[@"callback"];
    }
    NSString *backJson = [NSString stringWithFormat:@"%@('%@')",callBack, jsonStr];
    [self.h5View evaluateJavaScript:backJson completionHandler:nil];
}

//- (ELImagePicker *)imagePicker {
//    if (!_imagePicker) {
//        _imagePicker = [[ELImagePicker alloc] init];
//    }
//    return _imagePicker;
//}

#pragma mark - 加载失败处理
- (void)showErrorView {
    ELH5ErrorView *errorView = [ELH5ErrorView new];
    SBWS(weakSelf)
    errorView.buttonBlock = ^(){
        [weakSelf loadURL:self.h5URL];
    };
    [errorView showInView:self.view];
}

#pragma mark -
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"h5View.title"]) {
        NSString *title = change[NSKeyValueChangeNewKey];
        if (! self.navigationItem.title.length) {
            self.title = title;
        }
    } else if ([keyPath isEqualToString:@"h5View.estimatedProgress"]) {
        NSNumber *progress = change[NSKeyValueChangeNewKey];
        //        NSLog(@"hehe%@",progress);
        [self.progressView setProgress:progress.floatValue animated:YES];
    } else if ([keyPath isEqualToString:@"h5View.canGoBack"]) {
        [self updateLeftNavItems];
    }
}

#pragma mark - WKNavigationDelegate
//页面跳转的代理方法
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url = navigationAction.request.URL;
    NSString *path = url.absoluteString;
    UIApplication *app = SBApplication;
    if ([url.absoluteString containsString:@"itunes.apple.com"]) {
        if ([app canOpenURL:url]) {
            if ([app canOpenURL:url]) {
                [app openURL:url];
            }
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    if (!path || path.length == 0) {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    
    if ([path isEqualToString:@"about:blank"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    
    NSArray * temp = [path componentsSeparatedByString:@":"];
    NSString * funname = nil;
    NSString * params = nil;
    NSDictionary * dic = nil;
    if(temp.count > 0) {
        funname = [temp objectAtIndex:0];
    }
    
    funname = [funname lowercaseString];
    
    //打电话
    if ([funname isEqualToString:@"tel"]) {
        NSString *phoneNumber = nil;
        if (temp.count > 1) {
            phoneNumber = [temp objectAtIndex:1];
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:phoneNumber preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([app canOpenURL:url]) {
                [app openURL:url];
            }
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if (![funname isEqualToString:@"http"] && ![funname isEqualToString:@"https"]) {
        NSRange range = [path rangeOfString:@":"];
        if(range.location > 0 && range.location < (path.length-1)) {
            params = [path substringFromIndex:(range.location+1)];
            dic = [params sb_objectFromJSONString];
        }
    } else {
        [self hideRightBarButtonItem];
    }
    
    //网页返回
    if([funname isEqualToString:@"gowhere"]) {
        [self gobackH5:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    //6.0需求改动:定制导航栏－标题修改
    if ([funname isEqualToString:@"emh5title"]) {
        [self h5ContrlNativeTitle:dic];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    //获取通行证信息
    if ([[funname lowercaseString] hasPrefix:@"emh5getloginstatus"]) { //
        [self h5GetUserInfo:dic];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    //获取App设备信息
    if ([[funname lowercaseString] hasPrefix:@"getdeviceinfo"]) {
        [self h5GetDeviceInfo:dic];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    //直接关闭h5
    if ([[funname lowercaseString] isEqualToString:@"emh5close"]) {
        [self closeH5:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    //h5跳转
    if ([[funname lowercaseString] isEqualToString:@"emh5toopenapp"]) {
        BOOL jump = [self doH5Jump:dic params:params];
        if (jump) {
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    //分享
    if ([[funname lowercaseString] isEqualToString:@"emh5shareneed"]) {
        [self doShare:params];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    //js调用app分享
    if ([[funname lowercaseString] isEqualToString:@"onwebshareclicked"]) {
        [self h5ContrlNativeShare:dic];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    //复制黏贴
    if ([[funname lowercaseString] isEqualToString:@"emh5clipboard"]) {
        [self doPaste:dic];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    //新版上传照片，emh5screenshot为旧版
    if ([[funname lowercaseString] isEqualToString:@"emh5uploadphoto"] || [[funname lowercaseString] isEqualToString:@"emh5screenshot"]) {
        [self uploadPhoto:dic];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    //上传log反馈日志
    if ([[funname lowercaseString] isEqualToString:@"emh5uploadlog"]) {
        [self uploadLog:dic];
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if (error.code == NSURLErrorNotConnectedToInternet) {
        [self showErrorView];
    } else {
        DDLogInfo(@"didFailProvisionalNavigation error = %@",error);
    }
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    //记录
//    [SBExceptionLog record:self.h5URL.absoluteString key:DEBUG_EL_LIVE_H5URL];
    
    DDLogInfo(@"##h5 load URL %@##", self.h5URL);
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self.h5View evaluateJavaScript:@"injectCallback()" completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    DDLogInfo(@"didFailNavigation error = %@",error);
}
#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
