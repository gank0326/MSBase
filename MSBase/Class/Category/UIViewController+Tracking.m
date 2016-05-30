//
//  UIViewController+Tracking.m
//  MSBase
//
//  Created by ganshunwei on 16/5/30.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import <objc/runtime.h>

@implementation UIViewController (Tracking)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      Class class = [self class];
                      
                      SEL originalViewWillAppearSelector = @selector(viewWillAppear:);
                      SEL swizzledViewWillAppearSelector = @selector(tracking_viewWillAppear:);
                      
                      Method originalViewWillAppearMethod = class_getInstanceMethod(class, originalViewWillAppearSelector);
                      Method swizzledViewWillAppearMethod = class_getInstanceMethod(class, swizzledViewWillAppearSelector);
                      
                      BOOL didAddViewWillAppearMethod =class_addMethod
                      (
                       class,
                       originalViewWillAppearSelector,
                       method_getImplementation(swizzledViewWillAppearMethod),
                       method_getTypeEncoding(swizzledViewWillAppearMethod)
                       );
                      
                      if (didAddViewWillAppearMethod)
                      {
                          class_replaceMethod
                          (
                           class,
                           swizzledViewWillAppearSelector,
                           method_getImplementation(originalViewWillAppearMethod),
                           method_getTypeEncoding(originalViewWillAppearMethod)
                           );
                      }
                      else
                      {
                          method_exchangeImplementations(originalViewWillAppearMethod, swizzledViewWillAppearMethod);
                      }
                      
                      SEL originalViewWillDisappearSelector=@selector(viewWillDisappear:);
                      SEL swizzledViewWillDisappearSelector=@selector(tracking_viewWillDisappear:);
                      
                      Method originalViewWillDisappearMethod=class_getInstanceMethod(class, originalViewWillDisappearSelector);
                      Method swizzledViewWillDisappearMethod=class_getInstanceMethod(class, swizzledViewWillDisappearSelector);
                      
                      BOOL didAddViewWillDisappearMethod=class_addMethod
                      (
                       class,
                       originalViewWillDisappearSelector,
                       method_getImplementation(swizzledViewWillDisappearMethod),
                       method_getTypeEncoding(swizzledViewWillDisappearMethod)
                       );
                      if(didAddViewWillDisappearMethod)
                      {
                          class_replaceMethod
                          (
                           class,
                           originalViewWillDisappearSelector,
                           method_getImplementation(swizzledViewWillDisappearMethod),
                           method_getTypeEncoding(swizzledViewWillDisappearMethod)
                           );
                      }
                      else
                      {
                          method_exchangeImplementations(originalViewWillDisappearMethod, swizzledViewWillDisappearMethod);
                      }
                      
                      /*
                       SEL originalDeallocSelector= NSSelectorFromString(@"dealloc");
                       SEL swizzledDeallocSelector=@selector(tracking_dealloc);
                       
                       Method originalDeallocMethod=class_getInstanceMethod(class, originalDeallocSelector);
                       Method swizzledDeallocMethod=class_getInstanceMethod(class, swizzledDeallocSelector);
                       
                       BOOL didAddDeallocMethod=class_addMethod
                       (
                       class,
                       originalDeallocSelector,
                       method_getImplementation(swizzledDeallocMethod),
                       method_getTypeEncoding(swizzledDeallocMethod)
                       );
                       if(didAddDeallocMethod)
                       {
                       class_replaceMethod
                       (
                       class,
                       originalViewWillDisappearSelector,
                       method_getImplementation(swizzledDeallocMethod),
                       method_getTypeEncoding(swizzledDeallocMethod)
                       );
                       }
                       else
                       {
                       method_exchangeImplementations(originalDeallocMethod, swizzledDeallocMethod);
                       }
                       */
                  });
}

#pragma mark - Method Swizzling
- (void)tracking_viewWillAppear:(BOOL)animated
{
    [self tracking_viewWillAppear:animated];
    
    DDLogError(@"viewWillAppear: %@", self);
    
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

-(void)tracking_viewWillDisappear:(BOOL)animated
{
    [self tracking_viewWillDisappear:animated];
    
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

/*
 -(void)tracking_dealloc
 {
 DDLogVerbose(@"%@ dealloc, address : %p",self.class,self);
 
 [self tracking_dealloc];
 }
 */
@end
