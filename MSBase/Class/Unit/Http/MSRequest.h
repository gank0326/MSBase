//
//  MSRequest.h
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "YTKRequest.h"

@interface MSRequest : YTKRequest

/**请求方式*/
@property (nonatomic) YTKRequestMethod methodType;

/**业务接口名*/
@property (nonatomic,strong) NSString *methodUrl;

/**请求参数*/
@property (nonatomic,strong) NSDictionary *argument;

/**请求缓存，秒*/
@property (nonatomic) NSInteger cacheTime;

@end
