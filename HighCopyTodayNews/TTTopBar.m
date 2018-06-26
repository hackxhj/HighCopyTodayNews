//
//  TTTopBar.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/7/31.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "TTTopBar.h"


@interface TTTopBar ()
@property(nonatomic,strong) UIImageView *leftIconBtn;
@property(nonatomic,strong) UIView *centerView;
@property(nonatomic,strong) UIImageView *serachImg;
@property(nonatomic,strong) UILabel *searchTipLable;
@end


@implementation TTTopBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    if(self=[super init])
    {
        [self setupSubviews];
    }
    return self;
}


-(void)setupSubviews
{
    self.frame=CGRectMake(0, 0, kScreenWidth, [UIApplication topBarHeight]);

    self.backgroundColor=BaseColor;
    [self addSubview: self.leftIconBtn];
    [self addSubview: self.centerView];
    [self.centerView addSubview: self.serachImg];
    [self.centerView addSubview: self.searchTipLable];
 
    [self.leftIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.bottom.equalTo(self).offset(-8);
        
    }];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.leftIconBtn.mas_right).offset(15);
         make.right.equalTo(self).offset(-15);
         make.bottom.equalTo(self).offset(-8);
         make.height.mas_equalTo(30);
    }];
    [self.serachImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerView).offset(15);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.equalTo(self.centerView);
    }];
    
    [self.searchTipLable  mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.equalTo(self.centerView);
          make.left.equalTo(self.serachImg.mas_right).offset(10);
    }];
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        
    }
    return  self;
}

-(UIImageView *)leftIconBtn{
    if(!_leftIconBtn){
        _leftIconBtn=[UIImageView new];
        _leftIconBtn.image=[UIImage imageNamed:@"head-1"];
        _leftIconBtn.layer.cornerRadius=16;
        _leftIconBtn.layer.masksToBounds=YES;
    }
    return _leftIconBtn;
}

-(UIView*)centerView{
    if(!_centerView){
        _centerView=[UIView new];
        _centerView.layer.cornerRadius=4;
        _centerView.backgroundColor=[UIColor whiteColor];
    }
    return _centerView;
}

-(UIImageView*)serachImg{
    if(!_serachImg){
        _serachImg=[UIImageView new];
        _serachImg.image=[UIImage imageNamed:@"search_small"];

    }
    return _serachImg;
}

-(UILabel *)searchTipLable{
    if(!_searchTipLable){
        _searchTipLable=[UILabel new];
        _searchTipLable.font=[UIFont systemFontOfSize:13];
        _searchTipLable.text=@"搜索推荐|战狼2|美国";
        _searchTipLable.textColor=[UIColor colorWithRed:0.47 green:0.47 blue:0.47 alpha:1];
    }
    return _searchTipLable;
}
@end
