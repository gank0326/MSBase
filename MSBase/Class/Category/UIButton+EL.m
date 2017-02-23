//
//  UIButton+EL.m
//  EMLive
//
//  Created by roronoa on 16/5/7.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "UIButton+EL.h"

#import <objc/runtime.h>

static void *btnActionKey = &btnActionKey;

@implementation UIButton (elbutton)

- (ELBtnAction)btnAction {
    return objc_getAssociatedObject(self, &btnActionKey);
}

-(void)setBtnAction:(ELBtnAction)btnAction {
    objc_setAssociatedObject(self, & btnActionKey, btnAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
}

/**背景图片主色*/
- (void)el_main {
    UIImage *bImage = [UIImage sb_imageWithColor:[UIColor el_mainColor]];
    UIImage *dImage = [UIImage sb_imageWithColor:[UIColor el_btnUnableColor]];
    [self setBackgroundImage:bImage forState:UIControlStateNormal];
    [self setBackgroundImage:dImage forState:UIControlStateDisabled];
    
    //圆角
    if (self.height > 0) {
        self.layer.cornerRadius = self.height / 2;
    }
    else {
        self.layer.cornerRadius = 5.0f;
    }
    
    self.layer.masksToBounds = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

/**点击带缩放*/
- (void)el_scaleEffect {
    [self addTarget:self action:@selector(el_scaleToSmall) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(el_scaleAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(el_scaleToDefault) forControlEvents:UIControlEventTouchDragExit];
}

- (void)el_scaleToSmall
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.95f, 0.95f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)el_scaleAnimation
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 18.0f;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}

- (void)el_scaleToDefault
{
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}

//- (void)el_addBlockAction:(ELBtnAction)action {
//    self.btnAction = action;
//    [self addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
//}

- (void)onClick {
    if (self.btnAction) {
        self.btnAction(self);
    }
}


@end

static void *currentTimeKey = &currentTimeKey;
static void *resendTimerKey = &resendTimerKey;

@implementation UIButton (eltime)

- (NSNumber *)currentTime {
    return objc_getAssociatedObject(self, &currentTimeKey);
}

-(void)setCurrentTime:(NSNumber *)currentTime {
    objc_setAssociatedObject(self, & currentTimeKey, currentTime, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSString *time = [NSString stringWithFormat:@"%@",self.currentTime];
    NSString *title = [kDefaultSubTitle stringByReplacingOccurrencesOfString:@"ss" withString:time];
    [self setTitle:title forState:UIControlStateNormal];
}

- (NSTimer *)resendTimer {
    return objc_getAssociatedObject(self, &resendTimerKey);
}

-(void)setResendTimer:(NSTimer *)resendTimer {
    objc_setAssociatedObject(self, & resendTimerKey, resendTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)el_startWithTime:(NSInteger)second title:(NSString *)title subTitle:(NSString *)subTitle mainColor:(UIColor *)mColor grayColor:(UIColor *)gColor{
    if (subTitle.length < 1) {
        subTitle = kDefaultSubTitle;
    }
    self.currentTime = @(second);
    NSDictionary *info = @{@"second":@(second),
                           @"title":title,
                           @"subTitle":subTitle,
                           @"mColor":mColor,
                           @"gColor":gColor};
    [self.resendTimer invalidate];
    self.resendTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer:) userInfo:info repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.resendTimer forMode:NSDefaultRunLoopMode];
    [self.resendTimer fire];
}

- (void)handleTimer:(NSTimer *)timer {
    NSDictionary *info = timer.userInfo;
    if (self.currentTime.integerValue <= 0) { // 当i<=0了，停止Timer
        [self el_removeTimer];
        self.backgroundColor = info[@"mColor"];
        [self setTitle:info[@"title"] forState:UIControlStateNormal];
        self.enabled = YES;
    } else {
        self.backgroundColor = info[@"gColor"];
        self.currentTime = @(self.currentTime.integerValue - 1);
        NSString *title = info[@"subTitle"];
        NSString *time = [NSString stringWithFormat:@"%@",self.currentTime];
        title = [title stringByReplacingOccurrencesOfString:@"ss" withString:time];
        [self setTitle:title forState:UIControlStateNormal];
        self.enabled = NO;
    }
}

- (void)el_removeTimer {
    if (self.resendTimer) {
        [self.resendTimer invalidate];
        self.resendTimer = nil;
    }
}


@end

