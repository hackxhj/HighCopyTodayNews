//
//  CategoryAddView.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/7/31.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "CategoryAddView.h"

@interface CategoryAddView ()
@property(nonatomic,strong) UIImageView *addImg;
@end

@implementation CategoryAddView



-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
       [self initSubView];
    }
    return  self;
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    
    
}
-(void)initSubView{
 
   
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    UIView *whiteView=[UIView new];
    whiteView.backgroundColor=[UIColor whiteColor];
    [self addSubview:whiteView];
    [whiteView addSubview:self.addImg];

    
    UIImageView *leftShadowView=[UIImageView new];
    leftShadowView.image=[UIImage imageNamed:@"shadow"];
    [self addSubview:leftShadowView];
    
    
    [leftShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(2);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(5, 25));
 
    }];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.width.equalTo(@30);
    }];
 
    [self.addImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(23, 23));
        make.centerY.equalTo(whiteView);
        make.left.equalTo(whiteView).offset(0);
     }];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tipAction)];
    [self addGestureRecognizer:tapGesture];
    
    
}
-(void)tipAction{
 
    if([self.delegate respondsToSelector:@selector(clickAddCategory)])
    {
        [self.delegate clickAddCategory];
    }
}

-(UIImageView *)addImg
{
    if(!_addImg){
        _addImg=[UIImageView new];
        _addImg.image=[UIImage imageNamed:@"add_channel_titlbar_follow"];
    }
    return _addImg;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
