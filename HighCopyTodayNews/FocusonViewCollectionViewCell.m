//
//  FocusonViewCollectionViewCell.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/3.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "FocusonViewCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+YHAdd.h"
#import "LoadingButton.h"
#import "UIColor+YHAdd.h"
@interface FocusonViewCollectionViewCell ()
@property(nonatomic,strong)UIImageView *logoImg;
@property(nonatomic,strong)UILabel *mainLable;
@property(nonatomic,strong)UILabel *subLable;
@property(nonatomic,strong)LoadingButton *focusonBtn;
@property(nonatomic,strong)UIButton *closeBtn;
@property(nonatomic,strong)FocusonModel *model;
@end


@implementation FocusonViewCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame])
    {
        [self initSubView];
    }
    return self;
}
-(void)setUserInfo:(FocusonModel*)model
{
     _model=model;
    self.mainLable.text=model.user.info.name;
    self.subLable.text=model.user.info.desc;
    [self.logoImg sd_setImageWithURL:[NSURL URLWithString:model.user.info.avatar_url]];
     if(model.loadState==ButtonNormal){
        self.focusonBtn.enabled=YES;
        [self.focusonBtn setTitle:@"关注" forState:UIControlStateNormal];
        [self.focusonBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.focusonBtn.backgroundColor=[UIColor colorWithRed:0.13 green:0.56 blue:0.85 alpha:1];
 

    }else if(model.loadState==ButtonLoading){
        self.focusonBtn.enabled=NO;
        self.focusonBtn .backgroundColor=[UIColor colorWithRed:0.13 green:0.56 blue:0.85 alpha:1];
        [self.focusonBtn setTitle:@"" forState:UIControlStateNormal];
        [self.focusonBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }else if(model.loadState==ButtonUnLoading){
        self.focusonBtn.enabled=NO;
        self.focusonBtn.backgroundColor=[UIColor whiteColor];
        [self.focusonBtn setTitle:@"" forState:UIControlStateNormal];
        [self.focusonBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.focusonBtn.layer.cornerRadius=4;
        self.focusonBtn.layer.borderWidth=1;
        self.focusonBtn.layer.borderColor=[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1].CGColor;
    }
    else{
        self.focusonBtn.enabled=YES;
        [self.focusonBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [self.focusonBtn setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forState:UIControlStateNormal];
        self.focusonBtn.backgroundColor=[UIColor whiteColor];
        self.focusonBtn.layer.cornerRadius=4;
        self.focusonBtn.layer.borderWidth=1;
        self.focusonBtn.layer.borderColor=[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1].CGColor;

    }
    self.focusonBtn.loadState=model.loadState;

}


-(void)addFocusonAction:(id)sender{
    
    
    if([self.delegate respondsToSelector:@selector(onFoucesonUser:)])
    {
        [self.delegate onFoucesonUser:sender];
    }
}

-(void)closeFocusonAction:(id)sender{
    
    
    if([self.delegate respondsToSelector:@selector(onFoucesonClose:)])
    {
        [self.delegate onFoucesonClose:sender];
    }
}


-(void)initSubView{
    
    self.layer.cornerRadius=6;
    self.layer.borderWidth=1;
    self.layer.borderColor=[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1].CGColor;
    
    [self addSubview:self.logoImg];
    [self addSubview:self.mainLable];
    [self addSubview:self.subLable];
    [self addSubview:self.focusonBtn];
    [self addSubview:self.closeBtn];
    
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
          make.size.mas_equalTo(CGSizeMake(66, 66));
          make.centerX.equalTo(self);
          make.top.equalTo(self).offset(10);
    }];
    [self.mainLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
         make.centerX.equalTo(self);
         make.top.equalTo(self.logoImg.mas_bottom).offset(5);
     }];
    [self.subLable mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self).offset(15);
          make.right.equalTo(self).offset(-15);
          make.top.equalTo(self.mainLable.mas_bottom).offset(4);
          make.height.equalTo(@30);
          //make.bottom.equalTo(self.focusonBtn.mas_top).offset(-1);
        
    }];
    [self.focusonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self).offset(15);
          make.right.equalTo(self).offset(-15);
          make.height.equalTo(@28);
          make.bottom.equalTo(self).offset(-10);
        
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.size.mas_equalTo(CGSizeMake(25, 25));
           make.right.equalTo(self.mas_right).offset(-5);
           make.top.equalTo(self).offset(5);

    }];


}

-(UIImageView *)logoImg{
    if(!_logoImg){
        _logoImg=[UIImageView new];
        _logoImg.image=[UIImage imageNamed:@"head-1"];
         _logoImg.layer.cornerRadius=66/2;
        _logoImg.layer.masksToBounds=YES;
    }
    return _logoImg;
}
-(UILabel *)mainLable{
    if(!_mainLable){
        _mainLable=[UILabel new];
        _mainLable.text=@"心理学";
        _mainLable.font=[UIFont boldSystemFontOfSize:15];
        _mainLable.textColor=[UIColor blackColor];
        
    }
    return _mainLable;
}
-(UILabel *)subLable{
    if(!_subLable){
        _subLable=[UILabel new];
        _subLable.text=@"心理学自媒体";
        _subLable.numberOfLines=0;
        _subLable.textAlignment=NSTextAlignmentCenter;
        _subLable.font=[UIFont systemFontOfSize:12];
        _subLable.textColor=[UIColor blackColor];
    }
    return _subLable;
}
-(LoadingButton *)focusonBtn{
    if(!_focusonBtn){
        _focusonBtn=[LoadingButton new];
        [_focusonBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_focusonBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _focusonBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        _focusonBtn.backgroundColor=[UIColor colorWithRed:0.13 green:0.56 blue:0.85 alpha:1];
        _focusonBtn.layer.cornerRadius=5;
        [_focusonBtn addTarget:self action:@selector(addFocusonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _focusonBtn;
}
-(UIButton *)closeBtn{
    if(!_closeBtn){
        _closeBtn=[UIButton new];
         [_closeBtn setImage:[UIImage imageNamed:@"dislikeicon_details"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeFocusonAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _closeBtn;
}

@end
