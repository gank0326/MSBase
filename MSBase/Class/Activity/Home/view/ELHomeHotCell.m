//
//  ELHomeHotCell.m
//  EMLive
//
//  Created by liuxiaogang on 16/10/31.
//  Copyright © 2016年 roronoa. All rights reserved.
//

#import "ELHomeHotCell.h"

@implementation ELHomeHotCell

+ (CGSize)itemSizeForCollectionView:(CGSize)size {
    CGFloat width = (size.width - 20-10)/2;
    return CGSizeMake(width, (size.height-20)/2);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.maskView];
        [self.maskView addSubview:self.coverImgView];
        [self.maskView addSubview:self.topShadowImgView];
        [self.maskView addSubview:self.bottomShadowImgView];
        
        [self.contentView addSubview:self.distanceLabel];
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.nicknameLabel];
        [self.contentView addSubview:self.viewCountLabel];
        
        [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [self.coverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.maskView);
        }];
        
        [self.topShadowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.coverImgView.mas_top);
            make.left.equalTo(self.coverImgView.mas_left);
            make.right.equalTo(self.coverImgView.mas_right);
            
            make.height.equalTo(@60);
        }];
        
        [self.bottomShadowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.coverImgView.mas_left);
            make.bottom.equalTo(self.coverImgView.mas_bottom);
            make.right.equalTo(self.coverImgView.mas_right);
            
            make.height.equalTo(@60);
        }];
    
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.bottom.equalTo(self.nicknameLabel.mas_top).offset(-4);
            
            make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-8);
        }];
        
        [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
            make.left.equalTo(self.mas_left).offset(5);
            make.right.lessThanOrEqualTo(self.viewCountLabel.mas_left).offset(-4);
        }];
        
        [self.viewCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        }];
        
        [self.nicknameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                                        forAxis:UILayoutConstraintAxisVertical];
        [self.nicknameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                                        forAxis:UILayoutConstraintAxisHorizontal];
    }
    return self;
}


#pragma mark - Method


#pragma mark - Getter
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _maskView.layer.cornerRadius = 4;
        _maskView.layer.masksToBounds = YES;
        _maskView.backgroundColor = [UIColor yellowColor];
    }
    return _maskView;
}

- (UIImageView *)coverImgView {
    if (!_coverImgView) {
        _coverImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _coverImgView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImgView.clipsToBounds = YES;
    }
    return _coverImgView;
}

- (UIImageView *)topShadowImgView {
    if (!_topShadowImgView) {
        _topShadowImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        UIImage *image = [[UIImage imageNamed:@"el_img_video_frame_shadow_top"]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)
                          resizingMode:UIImageResizingModeStretch];
        _topShadowImgView.image = image;
    }
    return _topShadowImgView;
}

- (UIImageView *)bottomShadowImgView {
    if (!_bottomShadowImgView) {
        _bottomShadowImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        UIImage *image = [[UIImage imageNamed:@"el_img_video_frame_shadow"]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)
                        resizingMode:UIImageResizingModeStretch];
        _bottomShadowImgView.image = image;
    }
    return _bottomShadowImgView;
}



- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _distanceLabel.font = [UIFont systemFontOfSize:11];
        _distanceLabel.textColor = [UIColor whiteColor];
    }
    return _distanceLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _nameLabel.font =[UIFont systemFontOfSize:11];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _nicknameLabel.font =[UIFont systemFontOfSize:11];
        _nicknameLabel.textColor = [UIColor whiteColor];
    }
    return _nicknameLabel;
}

- (UILabel *)viewCountLabel {
    if (!_viewCountLabel) {
        _viewCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _viewCountLabel.font = [UIFont systemFontOfSize:11];
        _viewCountLabel.textColor = [UIColor whiteColor];
    }
    return _viewCountLabel;
}

@end
