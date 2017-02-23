//
//  MSOperation.h
//  MSBase
//
//  Created by ganshunwei on 17/2/23.
//  Copyright © 2017年 ganshunwei. All rights reserved.
//

//操作状态 用于重写SDK函数
typedef NS_ENUM(NSInteger, MSOperationState) {
    MSOperationStateReady,
    MSOperationStateExecuting,
    MSOperationStateFinished,
};

@interface MSOperation : NSOperation

@property (nonatomic, assign) MSOperationState state;         //仅仅是一个状态 外面不要调用
@property (nonatomic, assign) BOOL operateOK;               //是否操作成功
@property (nonatomic, copy) void(^operateSuccess)();        //操作成功
@property (nonatomic, copy) void(^operateFailed)();        //操作失败

@end
