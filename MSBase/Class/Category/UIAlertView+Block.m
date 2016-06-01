//
//  UIAlertView+Block.m
//  DondibuyShopping
//
//  Created by howard on 14-10-21.
//  Copyright (c) 2014年 howard. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

@implementation UIAlertView (Block)
static char comKey;
-(void)showAlertViewWithBlock:(CompleteAlertViewBlock)comBlock
{
   
    if(comBlock) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, &comKey, comBlock, OBJC_ASSOCIATION_COPY);
       
    }
     self.delegate = self;
    [self show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    CompleteAlertViewBlock comBlock = objc_getAssociatedObject(self, &comKey);
    if(comBlock) {
        comBlock((int)buttonIndex);
    }
}
@end
