//
//  TTTabBarItem.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/7/28.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "TTTabBarItem.h"
#import "Masonry.h"
#import "UIColor+YHAdd.h"

@implementation TTTabBarItem


-(instancetype)init{
    if(self=[super init]){
      
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
}

-(void)setup{
    [self addSubview:self.iconImgView];
    [self addSubview:self.showTitleLable];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(32, 32));
         make.centerX.equalTo(self);
         make.top.equalTo(self).offset(4);
    }];
    [self.showTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.iconImgView.mas_bottom).offset(-4);
         make.centerX.equalTo(self);

    }];
}


-(instancetype)initWithTitle:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectImg
{
     self=[super init];
     [self setup];
     _title=title;
    _noralImage=image;
    _highlightedImage=selectImg;
    
    self.showTitleLable.text=_title;
    self.iconImgView.image=_noralImage;
    return self;
    
}

-(void)setItemSelected:(BOOL)itemSelected{
    if(itemSelected){
        self.showTitleLable.textColor=BaseColor;
        self.iconImgView.image=_highlightedImage;


    }else{
        self.showTitleLable.textColor=[UIColor colorWithRed:0.36 green:0.36 blue:0.36 alpha:1];
        self.iconImgView.image=_noralImage;

    }
}




-(UILabel*)showTitleLable
{
    if(!_showTitleLable){
        _showTitleLable=[UILabel new];
        _showTitleLable.font=[UIFont systemFontOfSize:10];
    }
    return _showTitleLable;
}

-(UIImageView*)iconImgView{
    if(!_iconImgView){
        _iconImgView=[UIImageView new];
        
    }
    return _iconImgView;
}

@end
