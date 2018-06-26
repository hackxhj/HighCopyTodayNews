//
//  TTFullScreenLoadingView.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/9.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "TTFullScreenLoadingView.h"


@interface TTFullScreenLoadingView ()
@property(nonatomic,strong) UIImageView *centerImg;
@property(nonatomic,strong) UIImageView *throughImg;

@end


@implementation TTFullScreenLoadingView

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
        [self initSubView];
    }
    return self;
}


-(void)initSubView{
    self.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44-49);
    self.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    [self addSubview:self.centerImg];
    [self.centerImg addSubview:self.throughImg];

    [self.centerImg mas_makeConstraints:^(MASConstraintMaker *make) {
         make.center.equalTo(self);
         make.size.mas_equalTo(CGSizeMake(180, 135));
    }];
    
 
    [self.throughImg mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(self.centerImg);
        make.left.equalTo(self.centerImg).offset(-30);
        make.size.mas_equalTo(CGSizeMake(170, 100));
    }];
    
    
    
}


-(void)show{
    self.hidden=NO;
    self.throughImg.hidden=NO;
    [self loadAnimation];
 
}


-(void)loadAnimation
{
    [self.throughImg.layer removeAllAnimations];

 
    //关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation.duration = 1;
    //配置关键帧每一帧的值
    animation.values = @[@40,@160,@170];
    //    animation.path
    //配置关键帧每一帧起始时间,范围 0 - 1
    animation.keyTimes = @[@0.2,@0.7,@1];
   // animation.additive = YES;

    //配置关键帧每一帧之间的线性变换
     animation.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:
             kCAMediaTimingFunctionEaseIn],
            [CAMediaTimingFunction functionWithName:
             kCAMediaTimingFunctionLinear],
            [CAMediaTimingFunction functionWithName:
             kCAMediaTimingFunctionEaseOut],
             ];
    animation.repeatCount=MAXFLOAT;
    
    [self.throughImg.layer addAnimation:animation forKey:@"positionx"];
 
}

-(void)close{
    [self.throughImg.layer removeAllAnimations];
    self.hidden=YES;
}


-(UIImageView*)centerImg
{
    if(!_centerImg){
        _centerImg=[UIImageView new];
        _centerImg.image=[UIImage imageNamed:@"details_slogan01"];
        //_centerImg.alpha=0.9;

    }
    return _centerImg;
}

-(UIImageView *)throughImg
{
    if(!_throughImg){
        _throughImg=[UIImageView new];
        _throughImg.hidden=YES;
        _throughImg.contentMode=UIViewContentModeScaleToFill;
        _throughImg.image=[UIImage imageNamed:@"details_slogan03"];
         _throughImg.alpha=0.009;//0.013;
         UIColor *color = [UIColor blackColor];
       // _throughImg.backgroundColor = [color colorWithAlphaComponent:0.5];
    }
    return _throughImg;
}
@end
