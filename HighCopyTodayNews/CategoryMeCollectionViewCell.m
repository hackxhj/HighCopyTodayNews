//
//  CategoryMeCollectionViewCell.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "CategoryMeCollectionViewCell.h"
#import "CategoryTitleModel.h"

@interface CategoryMeCollectionViewCell ()
@property(nonatomic,strong) UILabel *showLable;
@property(nonatomic,strong) UIButton *delTipBtn;
@end


@implementation CategoryMeCollectionViewCell



-(id)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame])
    {
        [self configSubView];
        
    }
    return self;
}

-(void)configSubView{
     self.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    [self addSubview:self.showLable];
    [self addSubview:self.delTipBtn];
    
     [self.showLable mas_makeConstraints:^(MASConstraintMaker *make) {
          make.center.equalTo(self);
    }];
    [self.delTipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(18, 18));
         make.right.equalTo(self).offset(3);
         make.top.equalTo(self).offset(-3);
        

    }];
}

-(UILabel *)showLable{
    if(!_showLable){
        _showLable=[UILabel new];
        _showLable.font=[UIFont systemFontOfSize:15];
        _showLable.textColor=[UIColor blackColor];
        _showLable.text=@"内容";
    }
    return _showLable;
}
-(UIButton *)delTipBtn{
    if(!_delTipBtn){
        _delTipBtn=[UIButton new];
        _delTipBtn.hidden=YES;
        [_delTipBtn setImage:[UIImage imageNamed:@"deleteicon_channel"] forState:UIControlStateNormal];
        [_delTipBtn addTarget:self action:@selector(delclickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _delTipBtn;
}
-(void)setMyModel:(CategoryTitleModel*)model
{
    self.showLable.text=model.name;
    
}

-(void)delclickAction:(id)sender{
    if([self.delegate respondsToSelector:@selector(clickdelAction:)]){
        [self.delegate clickdelAction:sender];
    }
}



-(void)setIsEdit:(BOOL)isEdit{
    _isEdit=isEdit;
    if(_isEdit){
        self.delTipBtn.hidden=NO;
    }else{
        self.delTipBtn.hidden=YES;

    }
}


@end
