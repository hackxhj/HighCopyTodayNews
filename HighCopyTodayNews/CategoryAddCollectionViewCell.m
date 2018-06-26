//
//  CategoryAddCollectionViewCell.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "CategoryAddCollectionViewCell.h"
#import "CategoryTitleModel.h"

@interface CategoryAddCollectionViewCell()
@property(nonatomic,strong) UIImageView *addImg;
@property(nonatomic,strong) UILabel *showLable;

@end


@implementation CategoryAddCollectionViewCell



-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
 
    
}
-(id)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame])
    {
        [self configSubView];
        
    }
    return self;
}
-(void)configSubView{
    
    self.layer.cornerRadius=3;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 1;//阴影透明度，默认0
    self.layer.shadowRadius = 1;//阴影半径，默认3
    [self.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.bounds]CGPath]];//解决离屏渲染带来的卡顿
    
    self.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.addImg];
    [self addSubview:self.showLable];
    
    [self.addImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(12, 12));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(16);
        
    }];
    [self.showLable mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.addImg.mas_right).offset(3);
          make.centerY.equalTo(self);

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

-(UIImageView *)addImg{
    if(!_addImg){
        _addImg=[UIImageView new];
        _addImg.image=[UIImage imageNamed:@"add_channel_titlbar_follow"];
        
    }
    return _addImg;
}

-(void)setMyModel:(CategoryTitleModel*)model
{
    self.showLable.text=model.name;
    
}

@end
