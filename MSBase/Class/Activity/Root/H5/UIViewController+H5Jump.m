//
//  UIViewController+H5Jump.m
//  EMLive
//
//  Created by menglingchao on 16/9/8.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "UIViewController+H5Jump.h"

@implementation UIViewController (H5Jump)

/**h5界面跳转*/
- (BOOL)el_doH5Jump:(NSDictionary *)dic {
    /*
     appname = "haitunlive://";
     callbackname = callbackOpen;
     scheme = "emlive://jinyuzhibo.com/home?page=home_live_concern";
     */
//    NSString *appname = dic[@"appname"];
//    if ([appname isEqualToString:@"haitunlive://"]) {
//        NSString *scheme = dic[@"scheme"];
//        [self el_doH5JumpWithUrlString:scheme];
//    } else {
//        return [self el_jumpToOtherApp:appname];
//    }
    NSString *url = [dic objectForKey:@"scheme"];
    if (url) {
        return [self el_openURL:url];
    }
    NSString *appURL = [dic objectForKey:@"appname"];
    if (appURL) {
        return [self el_openURL:appURL];
    }
    return NO;
}

/*!直接传h5逻辑里面的scheme进行跳转*/
- (BOOL)el_doH5JumpWithUrlString:(NSString *)urlString {
    if (! urlString.length) {
        return NO;
    }
    if ([urlString hasPrefix:@"emlive://"]) {
        NSArray *sepratedStringArr = [urlString componentsSeparatedByString:@"/"]; //分割array
        NSString *jumpType = [sepratedStringArr lastObject]; //跳转页面类型
        //对无参数的scheme做解析
        BOOL ok = [self el_presentViewController:jumpType];
        if (ok) {
            return YES;
        }
        ok = [self el_pushViewControllerWithScheme:urlString];
        if (ok) {
            return YES;
        }
    } else if ([urlString hasPrefix:@"http://"] || [urlString hasPrefix:@"https://"]) {
        [self.navigationController sb_openCtrl:el_actionurl_h5(nil, [NSURL URLWithString:urlString])];
        return YES;
    }
    return NO;
}

// 无参数的scheme 跳转的页面
- (BOOL)el_presentViewController:(NSString *)jumpType {
    if ([jumpType isEqualToString:@"liverelease"]) {//发起直播
//        [self.view.window.rootViewController el_startPushLive:@""];
        return YES;
    } else if ([jumpType isEqualToString:@"myrecord"]) {//我的直播
        return ([self.navigationController sb_quickOpenCtrl:@"ELLiveListViewController"] != nil);
    } else if ([jumpType isEqualToString:@"near"]) {//附近
        return ([self.navigationController sb_quickOpenCtrl:@"ELNearPeopleViewController"] != nil);
    } else if ([jumpType isEqualToString:@"nearchannels"]) {//附近的直播
        return ([self.navigationController sb_quickOpenCtrl:@"ELNearLiveViewController"] != nil);
    } else if ([jumpType isEqualToString:@"search"]) {//搜索
        return ([self.navigationController sb_quickOpenCtrl:@"ELSearchViewController"] != nil);
    } else if ([jumpType isEqualToString:@"profile"]) {//个人资料
        return ([self.navigationController sb_quickOpenCtrl:@"ELUserEditViewController"] != nil);
    }
    return NO;
}
// 有参数的scheme push界面
- (BOOL)el_pushViewControllerWithScheme:(NSString *)scheme {
    //对有？的scheme重新做解析
    NSString *scheme1 = nil;
    NSString *scheme2 = nil;
    //切割scheme，前一半做跳转类型判断，后一半做具体跳转解析
    NSRange range = [scheme rangeOfString:@"?"];
    if(range.location > 0 && range.location < (scheme.length-1)) {
        scheme1 = [scheme substringToIndex:(range.location )];
        scheme2 = [scheme substringFromIndex:(range.location + 1)];
    }
    
    NSArray *sepratedStringArr2 = [scheme1 componentsSeparatedByString:@"/"];
    NSString *jumpType = [sepratedStringArr2 lastObject];
    
    NSDictionary *jumpDic = [scheme2 sb_objectFromJSONString];
    if ([jumpType isEqualToString:@"home"]) {
        return [self el_pushHomeTypeViewControllerWithJumpDic:jumpDic];
    } else if ([jumpType isEqualToString:@"live"]) {
        return [self el_pushLiveTypeViewControllerWithJumpDic:jumpDic];
    } else if ([jumpType isEqualToString:@"userrelationship"]) {
        return [self el_pushRelationshipWithJumpDic:jumpDic];
    } else if ([jumpType isEqualToString:@"topicchannel"]) {
        return [self el_pushTopicChannelWithJumpDic:jumpDic];
    } else if ([jumpType isEqualToString:@"hosthome"]) {
        NSString *userId = jumpDic[@"userId"];
        if (userId.length < 1) {
            [self.navigationController sb_quickOpenCtrl:@"ELMeViewController"];
        }
//        [self el_userHomePage:userId pDetail:nil];
        return YES;
    }
    return NO;
}
// push home类型的控制器
- (BOOL)el_pushHomeTypeViewControllerWithJumpDic:(NSDictionary *)jumpDic {
    /*
     page = "home_live_hot";
     */
    NSString *page = jumpDic[@"page"];
    if ([page isEqualToString:@"home_live_hot"]) {
        NSString *type = jumpDic[@"type"];
        if ([type isEqualToString:@"hot_money"]) {
//            return ([self sb_openCtrl:el_actionurl_tab_wealth(@"财富")] != nil);
        } else if ([type isEqualToString:@"hot_life"]) {
//            return ([self sb_openCtrl:el_actionurl_tab_life(@"生活")] != nil);
        } else if ([type isEqualToString:@"hot_hot"]) {
//            return ([self sb_openCtrl:el_actionurl_tab_hot(@"热门")] != nil);
        }
    } else if ([page isEqualToString:@"home_live_concern"]) {
        return ([self sb_quickOpenCtrl:@"ELMyFocusLiveViewController"] != nil);
    } else if ([page isEqualToString:@"home_live_new"]) {
        return ([self sb_quickOpenCtrl:@"ELLiveFindViewController"] != nil);
    } else if ([page  isEqualToString:@"home_me"]) {
        return ([self sb_quickOpenCtrl:@"ELMeViewController"] != nil);
    } else if ([page isEqualToString:@"diamonds"]) {
        return ([self sb_quickOpenCtrl:@"ELMyCoinsViewController"] != nil);
    }
    NSString *type = jumpDic[@"extra_live_type"];
    NSString *channel_id = jumpDic[@"channel_id"];
    if ([type integerValue] == 2 && channel_id.length > 0) {
//        return ([self sb_openCtrl:el_actionurl_watch_record(channel_id, nil)] != nil); //跳转录播
    }
    return NO;
}
// push live类型的控制器
- (BOOL)el_pushLiveTypeViewControllerWithJumpDic:(NSDictionary *)jumpDic {
    /*
     "channel_id" = 1005;
     "extra_live_type" = 1;
     */
    NSString *type = jumpDic[@"extra_live_type"];
    NSString *channel_id = jumpDic[@"channel_id"];
    if ([type integerValue] == 1 && channel_id.length > 0) {
//        return ([self sb_openCtrl:el_actionurl_watch_live(channel_id,nil)] != nil); //跳转看直播
    }
//    else if ([type integerValue] == 2) {
//        return [self sb_openCtrl:el_actionurl_watch_record(nil, jumpDic[@"channel_id"])]; //跳转录播
//    }
    return NO;
}

//跳转到关注、粉丝列表
- (BOOL)el_pushRelationshipWithJumpDic:(NSDictionary *)jumpDic {
//    NSString *relationshipType = jumpDic[@"relationshipType"];
//    NSString *userId = jumpDic[@"userId"];
//    
//    if (userId.length < 1) {
//        userId = [ELUserInfoUnit getUserID];
//    }
//    if ([relationshipType isEqualToString:@"follow"]) {
//        return ([self.navigationController sb_openCtrl:el_actionurl_followusers(userId)] != nil);
//    } else if ([relationshipType isEqualToString:@"fans"]) {
//        return ([self.navigationController sb_openCtrl:el_actionurl_fans(userId)] != nil);
//    }
    return NO;
}

//跳转至话题频道列表
- (BOOL)el_pushTopicChannelWithJumpDic:(NSDictionary *)jumpDic {
//    NSString *topic_id = jumpDic[@"topic_id"];
//    NSString *topic_introduce = jumpDic[@"topic_introduce"];
//    NSString *topic_name = jumpDic[@"topic_name"];
////    NSString *topic_type = jumpDic[@"topic_type"];
//    NSString *topic_url = jumpDic[@"topic_url"];
//    
//    NSString *stock_id = jumpDic[@"stock_id"];//这里应该是股票的id，H5字段名用错了，将错就错咯
//    
//    //拼成话题数据模型
//    DataItemDetail *itemDetail = [DataItemDetail detail];
//    [itemDetail setString:topic_id forKey:@"id"];
//    [itemDetail setString:topic_url forKey:@"image_url"];
//    [itemDetail setString:topic_introduce forKey:@"introduce"];
//    [itemDetail setString:topic_name forKey:@"name"];
//    [itemDetail setString:stock_id forKey:@"id"];
//    if (stock_id.length > 0) { //股票频道
//        return ([self.navigationController sb_openCtrl:el_actionurl_stockChannel(nil, itemDetail)] != nil);
//    } else { //话题频道
//        return ([self.navigationController sb_openCtrl:el_actionurl_topicChannel(topic_id, nil)] != nil);
//    }
    return NO;
}
// 跳转到其他app
- (BOOL)el_jumpToOtherApp:(NSString *)appname {
    if ([appname isEqualToString:@"eastmoneyjijin://"]) {
        NSURL* url = [NSURL URLWithString:appname];
        if ([SBApplication canOpenURL:url]) {
            return [SBApplication openURL:url];
        }
    }
    return NO;
}


//路由跳转
- (BOOL)el_openURL:(NSString *)url {
//    NSURLComponents *com = [[NSURLComponents alloc] initWithString:[url copy]];
//    NSString *scheme = [com.scheme lowercaseString];
//    //判断应用标志符，
//    if ([scheme isEqualToString:@"emlive"]) {
////        NSString *host = [com.host lowercaseString];
//        NSString *path = [com.path lastPathComponent];
//        NSArray *queryItems = com.queryItems;
//        NSMutableDictionary *querys = [[NSMutableDictionary alloc] init];
//        //参数转字典
//        [queryItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSString *key = [(NSURLQueryItem *)obj name];
//            NSString *value = [(NSURLQueryItem *)obj value];
//            [querys setObject:value forKey:key];
//        }];
//        
//        if ([path isEqualToString:@"home"]) {         //首页
//            NSString *page = [querys objectForKey:@"page"];
//            NSString *type = [querys objectForKey:@"type"];
//            if ([page isEqualToString:@"home_live_hot"] && [type isEqualToString:@"hot_hot"]) {  //首页-校园
//                [self sb_quickOpenCtrl:@"ELHotViewController"];
//                return YES;
//            } else if ([page isEqualToString:@"home_live_hot"] && [type isEqualToString:@"hot_money"]) { //首页-财富
//                [self sb_quickOpenCtrl:@"ELWealthViewController"];
//                return YES;
//            } else if ([page isEqualToString:@"home_live_hot"] && [type isEqualToString:@"school"]) {  //首页-校园
//                [self sb_quickOpenCtrl:@"ELCampusViewController"];
//                return YES;
//            }else if ([page isEqualToString:@"home_live_hot"] && [type isEqualToString:@"scene"]) {  //首页-现场
//                [self sb_quickOpenCtrl:@"ELSceneViewController"];
//                return YES;
//            } else if ([page isEqualToString:@"home_live_new"]) {  //首页-消息
//                [self sb_quickOpenCtrl:@"ELPrivateMsgController"];
//                return YES;
//            } else if ([page isEqualToString:@"home_live_concern"]) {  //首页-动态
//                [self sb_quickOpenCtrl:@"ELMomentsController"];
//                return YES;
//            } else if ([page isEqualToString:@"home_me"]) {  //首页-我
//                [self sb_quickOpenCtrl:@"ELMeViewController"];
//                return YES;
//            } else if ([page isEqualToString:@"diamonds"]) {    //我的钻石
//                NSURL *url = [ELURLHelper el_h5_giftGivingURLForUserid:[ELUserInfoUnit getUserID]];
//                [self.navigationController sb_openCtrl:el_actionurl_h5(@"", url)];
//                return YES;
//            }
//            return NO;
//        } else if ([path isEqualToString:@"live"]) {    //观看直播
//            NSString *channelId = [querys objectForKey:@"channel_id"];
//            NSInteger type = [[querys objectForKey:@"extra_live_type"] integerValue];
//            [self el_toWatchVideo:channelId type:type];
//            return YES;
//        } else if ([path isEqualToString:@"liverelease"]) {    //首页-发布直播
//            [self.view.window.rootViewController el_startPushLive:@""];
//            return YES;
//        } else if ([path isEqualToString:@"userrelationship"]) {    //关注列表
//            NSString *userID = [querys objectForKey:@"userId"];
//            NSString *relationship = [querys objectForKey:@"relationshipType"];
//            if ([relationship isEqualToString:@"follow"] ) {
//                [self.navigationController sb_openCtrl:el_actionurl_followusers(userID)];
//                return YES;
//            } else if ([relationship isEqualToString:@"fans"] ) {
//                [self.navigationController sb_openCtrl:el_actionurl_fans(userID)];
//                return YES;
//            }
//            return NO;
//        } else if ([path isEqualToString:@"profile"]) {    //个人资料
//            [self.navigationController sb_quickOpenCtrl:@"ELMeViewController"];
//            return YES;
//        } else if ([path isEqualToString:@"near"]) {        //附近
//            [self sb_quickOpenCtrl:@"ELNearLiveViewController"];
//            return YES;
//        } else if ([path isEqualToString:@"nearchannels"]) {    //附近的直播
//            [self sb_quickOpenCtrl:@"ELNearLiveViewController"];
//            return YES;
//        } else if ([path isEqualToString:@"topicchannel"]) {    //话题列表(生活)
//            BOOL isStock = [querys objectForKey:@"is_stock"];
//            if (isStock) {
//                NSString *stockCode = [querys objectForKey:@"stock_code"];
//                [self.navigationController sb_openCtrl:el_actionurl_stockChannel(stockCode, nil)];
//                return YES;
//            } else {
//                NSString *topicID = [querys objectForKey:@"topic_id"];
//                [self.navigationController sb_openCtrl:el_actionurl_topicChannel(topicID, nil)];
//                return YES;
//            }
//        } else if ([path isEqualToString:@"search"]) {    //搜索页面
//            [self.navigationController sb_quickOpenCtrl:@"ELSearchViewController"];
//            return YES;
//        } else if ([path isEqualToString:@"hosthome"]) {  //他人主页
//            NSString *userId = [querys objectForKey:@"userId"];
//            [self el_userHomePage:userId pDetail:nil];
//            return YES;
//        }
//        return NO;
//    } else if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
//        [self sb_openCtrl:el_actionurl_h5(nil, [NSURL URLWithString:url])];
//        return YES;
//    } else {
//        if ([SBApplication canOpenURL:[NSURL URLWithString:url]]) {
//            return [SBApplication openURL:[NSURL URLWithString:url]];
//        }
//    }
    return NO;
}

@end
