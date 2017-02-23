//
//  UIView+EL.m
//  EMLive
//
//  Created by Thomas Wang on 2016/11/22.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "UIView+EL.h"       //UIView 扩展

@implementation UIView(EL)

/*!移除某一约束*/
- (void)el_removeConstraintsWithFirstItem:(id)firstItem firstAttribute:(NSLayoutAttribute)firstAttribute {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == firstItem && constraint.firstAttribute == firstAttribute) {
            if ([constraint respondsToSelector:@selector(active)]) {
                constraint.active = NO;
            } else {
                [self removeConstraint:constraint];
            }
        }
    }
}

@end
