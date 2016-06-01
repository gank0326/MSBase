//
//  HZUIViewForGuide.m
//  Constraint
//
//  Created by huazi on 14-5-28.
//  Copyright (c) 2014年 AutoLayoutTestDemo. All rights reserved.
//

#import "MSGuideView.h"

@interface MSGuideView ()<UIScrollViewDelegate>
{
    NSArray *arrayPic;
    NSInteger countsPic;
}

@property (nonatomic ,strong) UIButton *intoButton;
@end

@implementation MSGuideView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (UIButton *)intoButton {
    if (!_intoButton) {
        _intoButton = [[UIButton alloc]initWithFrame:CGRectZero];
//        [_intoButton setTitle:@"立即体验" forState:UIControlStateNormal];
//        [_intoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _intoButton.backgroundColor = kThemeColor;
//        _intoButton.clipsToBounds = YES;
//        _intoButton.layer.cornerRadius = 4.0;
//        _intoButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0*Scale_Relative_320];
        [_intoButton addTarget:self action:@selector(TapToHideSelf:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _intoButton;
}

- (void)initSubviews:(UIWindow *)window picArr:(NSArray*)imageArr pageIcon:(UIImage*)icon pageSelectedIcon:(UIImage*)selectedIcon;
{
    arrayPic = imageArr;
    self.scrollView =[[UIScrollView alloc] initWithFrame:window.frame];
    [self addSubview:self.scrollView];
    if (arrayPic.count>0)
    {
        countsPic =[arrayPic count];
        self.scrollView.contentSize =CGSizeMake(SCREEN_WIDTH*countsPic, SCREEN_HEIGHT);
        self.scrollView.pagingEnabled =YES;
        self.scrollView.bounces =NO;
        self.scrollView.delegate = self;
        self.scrollView.showsVerticalScrollIndicator =NO;
        self.scrollView.showsHorizontalScrollIndicator =NO;
        for (int i=0; i<countsPic; i++)
        {
            UIImageView *image =[[UIImageView alloc] initWithFrame:CGRectMake(0+i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            image.image =[UIImage imageNamed:[arrayPic objectAtIndex:i]];
            [self.scrollView addSubview:image];
            if (i==countsPic-1)
            {
                image.userInteractionEnabled = YES;
                [image addSubview:self.intoButton];
                [self.intoButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(image);
                    make.bottom.equalTo(image).with.offset(-50);
                    make.width.equalTo(@200);
                    make.height.equalTo(@100);
                }];
            }
        }
    }
    
    window.hidden = NO;
    [window addSubview:self];
    self.pageControl = [[MSMyPageControl alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, 320, 48)];
    self.pageControl.activeImage = selectedIcon;
    self.pageControl.inactiveImage = icon;
    [_pageControl setNumberOfPages:4];
    [_pageControl setCurrentPage:0];
    [self addSubview:_pageControl];
   
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    int index = scrollView1.contentOffset.x/320;
    [_pageControl setCurrentPage:index];
}

- (void)TapToHideSelf:(id)sender
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         self.alpha =0.0f;
                     }
                     completion:^(BOOL finish)
     {
         [self removeFromSuperview];
         
         NSString *shortVersionKey = [MSAppCoreInfo shortVersionString];
         [[MSAppCoreInfo getCoreDB] setIntValue:kShowWelcomePage dataKey:shortVersionKey dataValue:1];
         
     }];
}

@end
