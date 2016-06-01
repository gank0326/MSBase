//
//  UIViewController+Popup.h
//  MSBase
//
//  Created by ganshunwei on 16/6/1.
//  Copyright © 2016年 ganshunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Popup)

@property (nonatomic) UIViewController *popupViewController;
@property (nonatomic) BOOL useBlurForPopup;
@property (nonatomic) CGPoint popupViewOffset;

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
- (void)dismissPopupViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;
- (void)setUseBlurForPopup:(BOOL)useBlurForPopup;
- (BOOL)useBlurForPopup;

@end
