//
//  LoadingButton.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/4.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "LoadingButton.h"


@interface LoadingButton ()

@end

@implementation LoadingButton

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
    self.loadState=ButtonNormal;
    [self addSubview:self.loadingImg];
}


-(void)setLoadState:(ButtonLoadState)loadState
{
   
    _loadState=loadState;

    if(loadState==ButtonLoading||loadState==ButtonUnLoading)
    {
        self.loadingImg.hidden=NO;
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.byValue = @(2 * M_PI);
        animation.duration = 0.5;
        animation.repeatCount = HUGE_VALF;
        [self.loadingImg.layer addAnimation:animation forKey:@"loading"];
        if(loadState==ButtonLoading){
            _loadingImg.image=[UIImage imageNamed:@"toast_keywords_refresh_white"];

        }else if(loadState==ButtonUnLoading){
            _loadingImg.image=[UIImage imageNamed:@"toast_keywords_refresh_gray"];

        }
     }
    else{
        self.loadingImg.hidden=YES;
        [self.loadingImg.layer removeAllAnimations];

    }

}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.loadingImg mas_makeConstraints:^(MASConstraintMaker *make) {
          make.size.mas_equalTo(CGSizeMake(12, 12));
          make.center.equalTo(self);
    }];
}

-(UIImageView *)loadingImg
{
    if(!_loadingImg){
        _loadingImg=[UIImageView new];
        _loadingImg.image=[UIImage imageNamed:@"toast_keywords_refresh_white"];
        _loadingImg.hidden=YES;
        
    }
    return _loadingImg;
}



@end
