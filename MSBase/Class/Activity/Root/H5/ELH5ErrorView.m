//
//  ELH5ErrorView.m
//  EMLive
//
//  Created by menglingchao on 16/11/16.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "ELH5ErrorView.h"

@interface ELH5ErrorView ()

/*!中介的视图*/
@property (nonatomic,strong) UIView *centerView;
/*!图片*/
@property (nonatomic,strong) UIImageView *imageView;
/*!标题*/
@property (nonatomic,strong) UILabel *titleLabel;
/*!按钮*/
@property (nonatomic,strong) UIButton *button;

@end

@implementation ELH5ErrorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor el_viewBackColor];
        [self centerView];
        [self imageView];
        [self titleLabel];
        [self button];
    }
    return self;
}

/*!加载到哪个视图上*/
- (void)showInView:(UIView *)view {
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
}

#pragma mark -
- (UIView *)centerView {
    if (! _centerView) {
        _centerView = [UIView new];
        [self addSubview:_centerView];
        [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return _centerView;
}
- (UIImageView *)imageView {
    if (! _imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"el_img_signal_default"]];
        [self.centerView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.centerView);
            make.width.equalTo(self.centerView);
            make.centerX.equalTo(self.centerView);
        }];
    }
    return _imageView;
}
- (UILabel *)titleLabel {
    if (! _titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = @"无网络\n请查看您的网络";
        [self.centerView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(20);
            make.centerX.equalTo(self.centerView);
        }];
    }
    return _titleLabel;
}
- (UIButton *)button {
    if (! _button) {
        _button = [UIButton new];
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button setBackgroundImage:[UIImage sb_imageWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
        _button.layer.borderColor = [UIColor el_lineColor].CGColor;
        _button.layer.borderWidth = 1;
        _button.layer.cornerRadius = 16;
        _button.clipsToBounds = YES;
        [_button setTitle:@"点击刷新" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor el_labelTitleColor] forState:UIControlStateNormal];
        WS(weakSelf)
        _button.btnAction = ^(UIButton *button){
            [weakSelf removeFromSuperview];
            if (weakSelf.buttonBlock) {
                weakSelf.buttonBlock();
            }
        };
        [self.centerView addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
            make.bottom.equalTo(self.centerView);
            make.centerX.equalTo(self.centerView);
            make.size.mas_equalTo(CGSizeMake(140, 32));
        }];
    }
    return _button;
}

@end
