//
//  MSOperation.m
//  MSBase
//
//  Created by ganshunwei on 17/2/23.
//  Copyright © 2017年 ganshunwei. All rights reserved.
//

#import "MSOperation.h"

@interface MSOperation()

@property (nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation MSOperation

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setState:MSOperationStateReady];
        _lock = [[NSRecursiveLock alloc]init];
    }
    return self;
}

- (void)start {
    [self setState:MSOperationStateExecuting];
}

- (void)setState:(MSOperationState)newState {
    [self.lock lock];
    if (newState == _state) {
        [self.lock unlock];
        return;
    }
    
    switch (newState) {
            case MSOperationStateReady:
            [self willChangeValueForKey:@"isReady"];
            break;
            case MSOperationStateExecuting:
            [self willChangeValueForKey:@"isReady"];
            [self willChangeValueForKey:@"isExecuting"];
            break;
            case MSOperationStateFinished:
            [self willChangeValueForKey:@"isExecuting"];
            [self willChangeValueForKey:@"isFinished"];
            break;
    }
    
    _state = newState;
    
    switch (newState) {
            case MSOperationStateReady:
            [self didChangeValueForKey:@"isReady"];
            break;
            case MSOperationStateExecuting:
            [self didChangeValueForKey:@"isReady"];
            [self didChangeValueForKey:@"isExecuting"];
            break;
            case MSOperationStateFinished:
            [self didChangeValueForKey:@"isExecuting"];
            [self didChangeValueForKey:@"isFinished"];
            break;
    }
    [self.lock unlock];
}

- (void)cancel{
    if (self.isFinished) {
        return;
    }
    if (self.state == MSOperationStateExecuting) {
        self.state = MSOperationStateFinished;
    }
    [super cancel];
}

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isReady
{
    
    return ([self state] == MSOperationStateReady && [super isReady]);
}

- (BOOL)isFinished
{
    return ([self state] == MSOperationStateFinished);
}

- (BOOL)isExecuting {
    
    return ([self state] == MSOperationStateExecuting);
}
@end
