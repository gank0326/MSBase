//
//  MSHttpProcess.h
//  MSBase
//
//  Created by ganshunwei on 16/6/20.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSRequest.h"

@interface MSHttpProcess : NSObject

/** 登录 */
+(MSRequest *)ms_loginmobile:(NSString *)mobile password:(NSString *)pwd;

@end
