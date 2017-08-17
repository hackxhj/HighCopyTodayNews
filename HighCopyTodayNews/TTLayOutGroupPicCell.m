//
//  TTLayOutGroupPicCell.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/15.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "TTLayOutGroupPicCell.h"
#import "FeedNewJsonModel.h"
#import "NSDate+YYAdd.h"
#import "UIImageView+WebCache.h"

@interface TTLayOutGroupPicCell ()
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *styleLable;
@property(nonatomic,strong)UILabel *bottomLable;
@property(nonatomic,strong)UIButton *delBtn;
@property(nonatomic,strong) UIView   *imgView;
@property(nonatomic,strong) UIView   *fengView;
@property(nonatomic,strong) FeedNewJsonModel *model;

@end


@implementation TTLayOutGroupPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    


}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    return self;
}


-(void)imgViewClick:(UITapGestureRecognizer*)tapGesture{
     if([self.delegate respondsToSelector:@selector(clickImg)])
     {
         [self.delegate clickImg];
     }
}


-(void)setModelDataWith:(FeedNewJsonModel*)model{
 
    _model=model;
    long long time=[model.publish_time longLongValue];
    NSDate *timedate=[NSDate dateFromTimeInterval:time];
    NSString *timeStr=[NSDate detailTimeAgoString:timedate];
    self.titleLable.text=model.title;
    self.bottomLable.text=[NSString stringWithFormat:@"%@  %@评论  %@",model.source,model.comment_count,timeStr];
    
    [self createImgCell:model.image_list];
    
}

-(void)removeOldView{
    for (UIView *view in [self.imgView subviews]) {
        if([view isKindOfClass:[UIImageView class]])
        {
             [ view removeFromSuperview];
            
        }
    }
}


-(NSString*)urldelwebpStr:(NSString*)str
{
    NSRange findRange=[str rangeOfString:@".webp"];
    NSString *newStr=str;
    if(findRange.location!=NSNotFound)
        newStr=[str substringWithRange:NSMakeRange(0, str.length-5)];
    
    return newStr;
}


-(void)createImgCell:(NSArray*)imgArrs{

    [self removeOldView];
    UIImageView *firstCell=nil;
    NSInteger space=5;//间距
    NSInteger maxCount=imgArrs.count>3? 3:imgArrs.count;
    
    for (int i=0;i<maxCount; i++) {
        
        Large_Image_List *model=imgArrs[i];
        UIImageView *imgcell=[UIImageView new];
        imgcell.tag=1000+i;
        imgcell.userInteractionEnabled=NO;
        //UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgViewClick:)];
        //[imgcell addGestureRecognizer:tapGesture];
 
        NSString*newStr=[self urldelwebpStr:model.url];
        [imgcell sd_setImageWithURL:[NSURL URLWithString:newStr] placeholderImage:[UIImage imageNamed:@"details_slogan01"]];
    
        [self.imgView addSubview:imgcell];
        if(i==0){
            firstCell=imgcell;
        }
        if(imgArrs.count==1||imgArrs.count==2)
        {
            [imgcell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo((kScreenWidth-35)/2);
                make.height.mas_equalTo(imgcell.mas_width).multipliedBy(0.65);
                NSInteger width= i==1? (kScreenWidth-35)/2+space:0;
                make.left.equalTo(self.contentView).offset(15+width);
                make.top.equalTo(self.titleLable.mas_bottom).offset(8);
            }];
        }else{
            [imgcell mas_makeConstraints:^(MASConstraintMaker *make) {
                
                // 计算每个cell的上 左间距
                NSInteger imgWidth=(kScreenWidth-35)/3;
                NSInteger xLeft= i;
                NSInteger line=0;
                make.width.mas_equalTo((kScreenWidth-35)/3);
                make.height.mas_equalTo(imgcell.mas_width).multipliedBy(0.65);
                make.left.equalTo(self.contentView).offset(15+(xLeft*(imgWidth+space)));
                make.top.equalTo(self.titleLable.mas_bottom).offset(8+(line*(imgWidth+space)));
            }];
        }
    
     }
    if(firstCell)
    {
        [self.bottomLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLable);
            make.top.equalTo(firstCell.mas_bottom).offset(10);
 
        }];
        
        [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLable.mas_bottom);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(firstCell.mas_bottom);
        }];
        
    }else{
        [self.bottomLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLable);
            make.top.equalTo(self.titleLable.mas_bottom).offset(10);
            
        }];
        
        [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLable.mas_bottom);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(@1);
            
        }];
    }
   
}





-(void)initSubView{
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.delBtn];
    [self.contentView addSubview:self.styleLable];
    [self.contentView addSubview:self.bottomLable];
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.fengView];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.contentView).offset(15);
          make.right.equalTo(self.contentView).offset(-15);
          make.top.equalTo(self.contentView).offset(20);
         // make.bottom.equalTo(self.contentView).offset(-15);

    }];
    
//    [self.styleLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titleLable);
//        make.top.equalTo(self.titleLable.mas_bottom).offset(10);
//        
//    }];
    [self.bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.titleLable);
         make.right.equalTo(self.contentView).offset(-15);
         make.top.equalTo(self.titleLable.mas_bottom).offset(10);
     }];
    
    [self.fengView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(self.bottomLable.mas_bottom).offset(10);
          make.left.equalTo(self.titleLable);
          make.bottom.equalTo(self.contentView).offset(-2).priorityHigh();
          make.right.equalTo(self.contentView);
          make.height.equalTo(@1);

    }];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
          make.size.mas_equalTo(CGSizeMake(44, 35));
          make.right.equalTo(self.contentView);
          make.bottom.equalTo(self.contentView);
        
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLable.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@1);
        
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UIButton *)delBtn
{
    if(!_delBtn){
        _delBtn=[UIButton new];
        [_delBtn setImage:[UIImage imageNamed:@"add_textpage"] forState:UIControlStateNormal];
        
    }
    return _delBtn;
}
-(UILabel*)bottomLable
{
    if(!_bottomLable){
        _bottomLable=[UILabel new];
        _bottomLable.textColor=[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1];
        _bottomLable.font=[UIFont systemFontOfSize:12];
        _bottomLable.text=@"专题 2222评论 一分钟前";
    }
    return _bottomLable;
}

-(UILabel *)titleLable
{
    if(!_titleLable){
        _titleLable=[UILabel new];
        _titleLable.font=[UIFont systemFontOfSize:18];
        _titleLable.textColor=[UIColor blackColor];
        _titleLable.numberOfLines=2;
        _titleLable.textAlignment=NSTextAlignmentLeft;
        _titleLable.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLable.preferredMaxLayoutWidth = kScreenWidth-30;
        _titleLable.text=@"我是标题";
    }
    return _titleLable;
}

-(UILabel *)styleLable
{
    if(!_styleLable){
        UIColor *color=BaseColor;
        _styleLable=[UILabel new];
        _styleLable.layer.cornerRadius=3;
        _styleLable.layer.masksToBounds=YES;
        _styleLable.text=@"置顶";
        _styleLable.layer.borderColor=color.CGColor;
        _styleLable.layer.borderWidth=0.5;
        _styleLable.textColor=color;
        _styleLable.font=[UIFont systemFontOfSize:11];
    }
    return _styleLable;
}

-(UIView  *)imgView
{
    if(!_imgView){
        _imgView=[UIView new];
        _imgView.backgroundColor=[UIColor clearColor];
        _imgView.userInteractionEnabled=NO;
    }
    return _imgView;
}

-(UIView *)fengView{
    if(!_fengView){
        _fengView=[UIView new];
        _fengView.backgroundColor=[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    }
    return _fengView;
}
@end
