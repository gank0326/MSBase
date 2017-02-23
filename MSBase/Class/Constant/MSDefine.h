//
//  MSDefine.h
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#ifndef MSDefine_h
#define MSDefine_h

#define EL3rdConfig(key) [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"EL3rdConfig"] objectForKey:key]
#define kThemeColor        RGB_A(247, 74,112, 1.0)//主题色
#define kShowWelcomePage              @"kShowWelcomePage"           //显示引导页


#pragma mark -API相关

#define API_BASE_URL    @"http://service.btdianyingtiantang.com/index.php/Home/"
#define kSignIn @"User/SignIn"  //登录

#endif /* MSDefine_h */
