//
//  CategoryCollectionReusableView.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "CategoryCollectionReusableView.h"


@interface CategoryCollectionReusableView ()


@end


@implementation CategoryCollectionReusableView


-(id)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame])
    {
       [self configSubView];
    }
    return self;
}

-(void)configSubView{
    [self addSubview:self.mainLable];
    [self addSubview:self.subLable];
    [self addSubview:self.editBtn];
    
    [self.mainLable mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self).offset(10);
          make.centerY.equalTo(self);
        
    }];
    [self.subLable mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.mainLable.mas_right).offset(8);
          make.bottom.equalTo(self.mainLable);
        
    }];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(52, 24));
         make.right.equalTo(self).offset(-10);
         make.centerY.equalTo(self);
    }];
}

-(UILabel *)mainLable
{
    if(!_mainLable){
        _mainLable=[UILabel new];
        _mainLable.text=@"我的频道";
        _mainLable.font=[UIFont systemFontOfSize:20];
        _mainLable.textColor=[UIColor blackColor];
    }
    return _mainLable;
}

-(UILabel *)subLable{
    if(!_subLable){
        _subLable=[UILabel new];
        _subLable.text=@"点击进入频道";
        _subLable.font=[UIFont systemFontOfSize:12];
        _subLable.textColor=[UIColor grayColor];
    }
    return _subLable;
}
-(UIButton *)editBtn
{
    if(!_editBtn){
        UIColor *color=BaseColor;
        _editBtn=[UIButton new];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:color forState:UIControlStateNormal];
        _editBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        _editBtn.layer.masksToBounds=YES;
        _editBtn.layer.cornerRadius=10;
        _editBtn.layer.borderWidth=1;
        _editBtn.layer.borderColor=color.CGColor;
        [_editBtn addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _editBtn;
}

-(void)editAction{
    if([self.delegate respondsToSelector:@selector(clickEditBtn)])
    {
        [self.delegate clickEditBtn];
    }
 
}


@end
