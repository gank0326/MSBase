//
//  MSHttpProcess.m
//  MSBase
//
//  Created by ganshunwei on 16/6/20.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSHttpProcess.h"

@implementation MSHttpProcess

+(MSRequest *)ms_loginmobile:(NSString *)mobile password:(NSString *)pwd {
    
    MSRequest *login = [MSRequest new];
    login.methodType = YTKRequestMethodPOST;
    login.methodUrl = kSignIn;
    login.argument = @{@"mobile":mobile,@"password":pwd};
    return login;
}

@end
