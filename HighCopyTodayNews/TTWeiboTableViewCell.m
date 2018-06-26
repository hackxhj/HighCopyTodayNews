//
//  TTWeiboTableViewCell.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/10.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "TTWeiboTableViewCell.h"
#import "YHButton.h"

#import "FeedNewJsonModel.h"
#import "UIImageView+WebCache.h"
#import "NSDate+YYAdd.h"
#import "UILabel+VerticalAlign.h"
#import <YYText/YYText.h>
#import "NSString+YHAdd.h"
#import "UIView+YHAdd.h"
@interface TTWeiboTableViewCell ()<CAAnimationDelegate>
@property(nonatomic,strong) UIImageView *avatarImgView;
@property(nonatomic,strong) UIButton *nameShowBtn;
@property(nonatomic,strong) UILabel *subShowLable;
@property(nonatomic,strong) YYLabel *contentLable;
@property(nonatomic,strong) UILabel *readcountLable;
@property(nonatomic,strong) UIView  *fengLineView;
@property(nonatomic,strong) YHButton *zangBtn;
@property(nonatomic,strong) YHButton *commentBtn;
@property(nonatomic,strong) YHButton *forwardBtn;
@property(nonatomic,strong) UIView   *sectionFengView;
@property(nonatomic,strong) UIView   *imgView;
@property(nonatomic,strong) FeedNewJsonModel *model;
@property(nonatomic,strong) UIImageView *zangPlusImg;
@end



@implementation TTWeiboTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    return self;
}
-(void)setModelDataWith:(FeedNewJsonModel*)model
{
    _model=model;
    [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:model.user.avatar_url]];
    [self.nameShowBtn setTitle:model.user.screen_name forState:0];
    long long time=[model.create_time longLongValue];
    NSDate *timedate=[NSDate dateFromTimeInterval:time];
    NSString *timeStr=[NSDate detailTimeAgoString:timedate];
    self.subShowLable.text=[NSString stringWithFormat:@"%@ . %@",timeStr,model.user.verified_content];
    
    self.readcountLable.text=[NSString stringWithFormat:@"%@阅读",[TTWeiboTableViewCell shortShow:model.read_count]];
    [self.zangBtn setTitle:[TTWeiboTableViewCell shortShow:model.digg_count] forState:0];
    [self.commentBtn setTitle:[TTWeiboTableViewCell shortShow:model.comment_count] forState:0];
    [self.forwardBtn setTitle:[TTWeiboTableViewCell shortShow:model.forward_info.forward_count] forState:0];
  
    if([model.user_digg isEqualToNumber:@1]){
        [_zangBtn setImage:[UIImage imageNamed:@"comment_like_icon_press"] forState:UIControlStateNormal];

    }else{
        [_zangBtn setImage:[UIImage imageNamed:@"c_comment_like_icon"] forState:UIControlStateNormal];

    }
    

    if(model.content.length>97){
    
        NSString *mainShow=[model.content substringWithRange:NSMakeRange(0, 97)];
        mainShow=[mainShow stringByAppendingString:@"...全文"];
        NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: mainShow];
        text.yy_lineSpacing = 5;
        text.yy_font = [UIFont systemFontOfSize:15];
       WEAKSELF
       [text yy_setTextHighlightRange:NSMakeRange(mainShow.length-2, 2) color:[UIColor colorWithRed:0.24 green:0.39 blue:0.61 alpha:1] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
           
           if([self.delegate respondsToSelector:@selector(clickDetail:)]){
               [self.delegate clickDetail:containerView];
           }

       }];
        self.contentLable.attributedText = text;

    }else{
        NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: model.content];
        text.yy_lineSpacing = 5;
        text.yy_font = [UIFont systemFontOfSize:15];
        self.contentLable.attributedText = text;
     }
 
    [self createImgCell:model.thumb_image_list];
}


-(void)imgViewClick:(UITapGestureRecognizer*)tapGesture
{
    NSMutableArray *imgLists=[NSMutableArray new];
    for (Large_Image_List *lModel in _model.large_image_list) {
        [imgLists addObject:lModel.url];
    }
    
 
    
    NSInteger tag=tapGesture.view.tag;
    if([self.delegate respondsToSelector:@selector(clickImgShow:imgS:)]){
        [self.delegate clickImgShow:tag-1000 imgS:imgLists];
    }
 
}

-(void)zangAction:(id)sender
{
//    if([_model.user_digg isEqualToNumber:@1])
//        return;
    
    [self zangPlayAnimation];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(zangClick:)])
        {
            [self.delegate zangClick:sender];
        }
    });
 

}

-(void)zangPlayAnimation{
    
    [_zangBtn setImage:[UIImage imageNamed:@"comment_like_icon_press"] forState:UIControlStateNormal];
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
            self.zangBtn.transform = CGAffineTransformMakeScale(1.3f, 1.3f); // 放大
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
            self.zangBtn.transform = CGAffineTransformMakeScale(0.8f, 0.8f); // 放小
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
            self.zangBtn.transform = CGAffineTransformMakeScale(1.0f, 1.0f); //恢复原样
        }];
    } completion:nil];
    
    
    self.zangPlusImg.alpha=1;
    self.zangPlusImg.frame=CGRectMake(66, 0, 15, 15);
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 1.5;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(66, 8)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(66, -6)];
    animation.delegate = self;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.values=@[value1,value2];
    [self.zangPlusImg.layer addAnimation:animation forKey:nil];
 
    
}
-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    
     self.zangPlusImg.alpha=0;

}

+(NSString*)shortShow:(NSNumber*)count
{
    long result;
    long num=[count longValue];
    if(num>=10000){
        result=num/10000;
        return [NSString stringWithFormat:@"%ld万",result];
    }else{
        result=num;
        return  [NSString stringWithFormat:@"%ld",result];
    }
}


-(void)removeOldView{
    for (UIView *view in [self.imgView subviews]) {
          if([view isKindOfClass:[UIImageView class]])
          {
              if(view.tag!=1111)
                [ view removeFromSuperview];
         }
    }
}


// 动态创建image cell

-(void)createImgCell:(NSArray*)imgArrs{
    
    [self removeOldView];
    
    UIImageView *lastCell=nil;
    NSInteger space=5;//间距
    for (int i=0;i<imgArrs.count; i++) {
        
        Thumb_Image_List *model=imgArrs[i];
        UIImageView *imgcell=[UIImageView new];
        imgcell.tag=1000+i;
        imgcell.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgViewClick:)];
       [imgcell addGestureRecognizer:tapGesture];
        [imgcell sd_setImageWithURL:[NSURL URLWithString:model.url]];
        [self.imgView addSubview:imgcell];
         if(imgArrs.count==1||imgArrs.count==2)
         {
              [imgcell mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.size.mas_equalTo(CGSizeMake((kScreenWidth-35)/2, (kScreenWidth-35)/2));
                  NSInteger width= i==1? (kScreenWidth-35)/2+space:0;
                  make.left.equalTo(self.contentView).offset(15+width);
                  make.top.equalTo(self.contentLable.mas_bottom).offset(8);
               }];
         }else{
             [imgcell mas_makeConstraints:^(MASConstraintMaker *make) {
                 
                 // 计算每个cell的上 左间距
                 NSInteger imgWidth=(kScreenWidth-35)/3;
                 NSInteger xLeft= i<3? i:i%3;
                 NSInteger line=0;
                 if(i<3)
                     line=0;
                 else if(i>=3&&i<6)
                     line=1;
               
                 else if(i>=6&&i<9)
                     line=2;
                 
                 make.size.mas_equalTo(CGSizeMake(imgWidth, imgWidth));
                 make.left.equalTo(self.contentView).offset(15+(xLeft*(imgWidth+space)));
                 make.top.equalTo(self.contentLable.mas_bottom).offset(8+(line*(imgWidth+space)));
             }];
         }
        lastCell=imgcell;
    }
    if(lastCell)
    {
        [self.readcountLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImgView);
            make.top.equalTo(lastCell.mas_bottom).offset(10);
            
        }];
        [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLable.mas_bottom);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(lastCell.mas_bottom);
        }];
        
    }else{

        
        [self.readcountLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImgView);
            make.top.equalTo(self.contentLable.mas_bottom).offset(10);
            
        }];
        
        [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLable.mas_bottom);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(@1);
            
        }];
    }

    
}




-(void)initSubView{
    [self.contentView addSubview:self.avatarImgView];
    [self.contentView addSubview:self.nameShowBtn];
    [self.contentView addSubview:self.subShowLable];
    [self.contentView addSubview:self.contentLable];
    [self.contentView addSubview:self.readcountLable];
    [self.contentView addSubview:self.fengLineView];
    [self.contentView addSubview:self.zangBtn];
    [self.contentView addSubview:self.commentBtn];
    [self.contentView addSubview:self.forwardBtn];
    [self.contentView addSubview:self.sectionFengView];
    [self.contentView addSubview:self.imgView];
    
    [self.avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15).priorityHigh();
        make.size.mas_equalTo(CGSizeMake(36, 36)).priorityHigh();
        make.top.equalTo(self.contentView).offset(15).priorityHigh();
        

    }];
    
    [self.nameShowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImgView.mas_right).offset(10);
        make.top.equalTo(self.avatarImgView);
        make.size.mas_equalTo(CGSizeMake(110, 20));
        
    }];
    [self.subShowLable mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.nameShowBtn);
          make.top.equalTo(self.nameShowBtn.mas_bottom).offset(3);
    }];
 
    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImgView);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.avatarImgView.mas_bottom).offset(15);
     }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.contentLable.mas_bottom);
         make.left.equalTo(self);
         make.right.equalTo(self);
         make.height.equalTo(@1);

    }];
    [self.readcountLable mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.avatarImgView);
         make.top.equalTo(self.contentLable.mas_bottom).offset(10);
        
    }];
    [self.fengLineView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.size.mas_equalTo(CGSizeMake(kScreenWidth, 0.5));
          make.left.equalTo(self.contentView);
          make.top.equalTo(self.readcountLable.mas_bottom).offset(6);
     }];
    [self.zangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, 36));
          make.left.equalTo(self.contentView);
          make.top.equalTo(self.fengLineView.mas_bottom).offset(6);

    }];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.zangBtn);
        make.left.equalTo(self.zangBtn.mas_right);
        make.top.equalTo(self.zangBtn);
        
    }];
    [self.forwardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.zangBtn);
        make.left.equalTo(self.commentBtn.mas_right);
        make.top.equalTo(self.zangBtn);
        
    }];
    [self.sectionFengView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.size.mas_equalTo(CGSizeMake(kScreenWidth, 5));
          make.top.equalTo(self.zangBtn.mas_bottom);
          make.left.equalTo(self.contentView);
          make.bottom.equalTo(self.contentView);
     }];
}





-(UIImageView *)avatarImgView{
    if(!_avatarImgView){
        _avatarImgView=[UIImageView new];
        _avatarImgView.tag=1111;
        _avatarImgView.layer.cornerRadius=36/2;
        _avatarImgView.layer.masksToBounds=YES;
        _avatarImgView.layer.borderWidth=0.5;
        _avatarImgView.layer.borderColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1].CGColor;

    }
    return _avatarImgView;
}

-(UIButton *)nameShowBtn{
    if(!_nameShowBtn){
        _nameShowBtn=[UIButton new];
        [_nameShowBtn setTitle:@"测试" forState:UIControlStateNormal];
        _nameShowBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        [_nameShowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _nameShowBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        

        
    }
    return _nameShowBtn;
}
-(UILabel *)subShowLable{
    if(!_subShowLable){
        _subShowLable=[UILabel new];
        _subShowLable.text=@"xx小时前 . 主持人";
        _subShowLable.font=[UIFont systemFontOfSize:12];
        _subShowLable.textColor=[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1];

    }
    return _subShowLable;
}


-(YYLabel *)contentLable{
    if(!_contentLable){
        _contentLable=[YYLabel new];
        _contentLable.numberOfLines=0;
        _contentLable.font=[UIFont systemFontOfSize:15];
        _contentLable.textColor=[UIColor blackColor];
        _contentLable.textAlignment=NSTextAlignmentLeft;
        _contentLable.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLable.preferredMaxLayoutWidth = kScreenWidth-30;

    }
    return _contentLable;
    
}
-(UILabel *)readcountLable{
    if(!_readcountLable){
        _readcountLable=[UILabel new];
        _readcountLable.font=[UIFont systemFontOfSize:12];
        _readcountLable.textColor=[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1];
    }
    return _readcountLable;
    
}
-(UIView  *)fengLineView{
    if(!_fengLineView){
        _fengLineView=[UIView new];
        _fengLineView.backgroundColor=[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
        
    }
    return _fengLineView;
    
}
-(YHButton *)zangBtn{
    if(!_zangBtn){
        _zangBtn=[YHButton new];
        [_zangBtn setImage:[UIImage imageNamed:@"c_comment_like_icon"] forState:UIControlStateNormal];
        [_zangBtn setTitle:@"1.8万" forState:UIControlStateNormal];
        [_zangBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _zangBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        _zangBtn.imageRect=CGRectMake(kScreenWidth/3/2-25, 6, 24, 24);
        _zangBtn.titleRect=CGRectMake(kScreenWidth/3/2, 9, 80, 16);
        [_zangBtn addTarget:self action:@selector(zangAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_zangBtn addSubview:self.zangPlusImg];
        
    }
    return _zangBtn;
    
}
-(YHButton *)commentBtn{
    if(!_commentBtn){
         _commentBtn=[YHButton new];
        [_commentBtn setImage:[UIImage imageNamed:@"comment_feed"] forState:UIControlStateNormal];
        [_commentBtn setTitle:@"100" forState:UIControlStateNormal];
        [_commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _commentBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        _commentBtn.imageRect=CGRectMake(kScreenWidth/3/2-25, 6, 24, 24);
        _commentBtn.titleRect=CGRectMake(kScreenWidth/3/2, 9, 80, 16);
    }
    return _commentBtn;
}
-(YHButton*)forwardBtn{
    if(!_forwardBtn){
        _forwardBtn=[YHButton new];
        [_forwardBtn setImage:[UIImage imageNamed:@"feed_share"] forState:UIControlStateNormal];
        [_forwardBtn setTitle:@"101" forState:UIControlStateNormal];
        [_forwardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _forwardBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        _forwardBtn.imageRect=CGRectMake(kScreenWidth/3/2-25, 6, 24, 24);
        _forwardBtn.titleRect=CGRectMake(kScreenWidth/3/2, 9, 80, 16);
    }
    return _forwardBtn;
}
-(UIView *)sectionFengView{
    if(!_sectionFengView){
        _sectionFengView=[UIView new];
        _sectionFengView.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
        
    }
    return _sectionFengView;
}

-(UIView  *)imgView
{
    if(!_imgView){
        _imgView=[UIView new];
        _imgView.backgroundColor=[UIColor clearColor];
    }
    return _imgView;
}
-(UIImageView *)zangPlusImg{
    if(!_zangPlusImg){
        _zangPlusImg=[UIImageView new];
        _zangPlusImg.image=[UIImage imageNamed:@"add_all_dynamic"];
        _zangPlusImg.alpha=0;
    }
    return _zangPlusImg;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
