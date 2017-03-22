//
//  JCServiceView.m
//  ChatApp
//
//  Created by fangchuang on 15/8/31.
//  Copyright (c) 2015年 juchuang. All rights reserved.
//

#import "JCServiceView.h"
#import "MHKnowledgeListController.h"

@interface JCServiceView(){
    NSDictionary *currentDic;
    NSString *categoryId;
}
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *nameLabel;
@end
@implementation JCServiceView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor=[UIColor redColor];
    }
    return self;
}
-(void)fillData:(NSDictionary *)dict{
    //    self.backgroundColor=[UIColor whiteColor];
    currentDic=dict;
    categoryId = [currentDic objectForKey:@"typeid"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:[dict objectForKey:@"pic"]]];
    self.nameLabel.text=[dict objectForKey:@"name"];
    
    UITapGestureRecognizer *tapGr= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = NO;
    [self  addGestureRecognizer:tapGr];
}

-(void)viewTapped {
    NSInteger type  = [[currentDic objectForKey:@"typeid"] integerValue];
    if (type == 1) {
        MHKnowledgeListController *list = [MHKnowledgeListController new];
        [MSHelper pushViewControllerAtFirstMainTab:list animate:YES];
    }
    else {
        [(UITabBarController *)[MSHelper getMainView] setSelectedIndex:(type -1)];
    }
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake((self.width-60)/2, 18, 60, 60)];
        _imageView.backgroundColor=[UIColor clearColor];
        [self addSubview:_imageView];
    }
    return _imageView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake((self.width-60)/2, CGRectGetMaxY(self.imageView.frame)+5, 60, 20)];
        _nameLabel.font=[UIFont systemFontOfSize:14.0];
        _nameLabel.backgroundColor=[UIColor clearColor];
        _nameLabel.textColor=[UIColor el_titleColor];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
        
    }
    return _nameLabel;
}


@end
