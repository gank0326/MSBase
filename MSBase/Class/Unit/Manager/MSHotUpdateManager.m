//
//  MSHotUpdateManager.m
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "MSHotUpdateManager.h"

static NSString *const JSPatchKey  = @"12a133479463223a";
@implementation MSHotUpdateManager

+ (void)install {
//    [JSPatch startWithAppKey:JSPatchKey runAfterFetch:YES];
    [JPEngine startEngine];
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    [JPEngine evaluateScript:script];
}

@end
