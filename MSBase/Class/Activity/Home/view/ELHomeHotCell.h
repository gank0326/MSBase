//
//  ELHomeHotCell.h
//  EMLive
//
//  Created by liuxiaogang on 16/10/31.
//  Copyright © 2016年 roronoa. All rights reserved.
//


@interface ELHomeHotCell : UICollectionViewCell

@property (nonatomic, strong) UIView *maskView;//遮罩父视图
@property (nonatomic, strong) UIImageView *coverImgView;//直播图片
@property (nonatomic, strong) UIImageView *topShadowImgView;//遮罩
@property (nonatomic, strong) UIImageView *bottomShadowImgView;//遮罩
@property (nonatomic, strong) UILabel *distanceLabel;//位置

@property (nonatomic, strong) UILabel *nameLabel;//直播间名称
@property (nonatomic, strong) UILabel *nicknameLabel;//用户昵称
@property (nonatomic, strong) UILabel *viewCountLabel;//观看人数

+ (CGSize)itemSizeForCollectionView:(CGSize)size;

@end
