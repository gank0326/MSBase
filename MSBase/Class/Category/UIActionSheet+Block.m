//
//  UIActionSheet+Block.m
//  DondibuyShopping
//
//  Created by howard on 14/11/11.
//  Copyright (c) 2014年 howard. All rights reserved.
//

#import "UIActionSheet+Block.h"
#import <objc/runtime.h>

@implementation UIActionSheet (Block)
static char finishKey;
-(void)showInViewWithBlock:(UIView *)view block:(FinishActionSheetBlock)finishBlock
{
    if(finishBlock) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, &finishKey, finishBlock, OBJC_ASSOCIATION_COPY);
    }
    self.delegate = self;
    [self showInView:view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    FinishActionSheetBlock finishBlock = objc_getAssociatedObject(self, &finishKey);
    if(finishBlock) {
        finishBlock((int)buttonIndex);
    }
}

@end
