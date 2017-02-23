//
//  UIView+EL.h
//  EMLive
//
//  Created by Thomas Wang on 2016/11/22.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import <Foundation/Foundation.h>


//为 应用中的UIView添加统一样式
@interface UIView (EL)

/*!移除某一约束*/
- (void)el_removeConstraintsWithFirstItem:(id)firstItem firstAttribute:(NSLayoutAttribute)firstAttribute;

@end

