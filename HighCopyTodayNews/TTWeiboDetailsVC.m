//
//  TTWeiboDetailsVC.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/16.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "TTWeiboDetailsVC.h"
#import <WebKit/WebKit.h>
#import "TTHomeRequest.h"
#import "FeedNewJsonModel.h"
#import "UIImageView+WebCache.h"
#import "NSDate+YYAdd.h"
#import "TTWeiboTableViewCell.h"
#import "TTWeiboShowImageView.h"
#import "TTHomeRequest.h"
#import "NSString+YHAdd.h"
#import "WeiboCommentModel.h"
#import <YYModel/YYModel.h>
#import "TTWeiboCommentCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "TTFullScreenLoadingView.h"

@interface TTWeiboDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIView *userTopView;
@property(nonatomic,strong) UIView *contentView;
@property(nonatomic,strong) UIImageView *avatarImgView;
@property(nonatomic,strong) UIButton *nameShowBtn;
@property(nonatomic,strong) UILabel *subShowLable;
@property(nonatomic,strong) UILabel *contentLable;
@property(nonatomic,strong) UILabel *readcountLable;
@property(nonatomic,strong) UIView  *fengLineView;
@property(nonatomic,strong) UIView   *imgView;
@property(nonatomic,strong) UIView *showTopView;
@property(nonatomic,strong) UIView *showTopFengView;

@property(nonatomic,strong) UILabel*showCommentLable;
@property(nonatomic,strong) UILabel*showZangCountLable;

@property(nonatomic,strong) UITableView *mainTableView;
@property(nonatomic,strong) NSArray *dataArrs;
@property(nonatomic,strong) TTFullScreenLoadingView *fullLoadingView;

//@property(nonatomic,strong) WKWebView *webView;
@end
static NSString *const cellfidf=@"TTWeiboCommentCell";

@implementation TTWeiboDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
//     self.webView.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//     [self.view addSubview:self.webView];
//    [TTHomeRequest weiboGetContent:self.thread_id complete:^(NSString *msg, id responseData) {
//        if([responseData[@"err_no"] integerValue]==0){
//            NSString *htmlStr=responseData[@"content"];
//            [self.webView loadHTMLString:htmlStr baseURL:nil];
//        }
//    }];

    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
        
    }];
    [self.mainTableView addSubview:self.fullLoadingView];
    [self.fullLoadingView show];

    [self initSubView];
    [self setModelDataWith];
    [self loadComments];
    
}

-(void)loadComments{
    
    NSRange startRange=[self.model.schema rangeOfString:@"fid="];
    NSRange endRange=[self.model.schema rangeOfString:@"&"];
    NSString *fid=[self.model.schema substringWithRange:NSMakeRange(startRange.location+4, endRange.location-(startRange.location+4))];
    
    [TTHomeRequest getCommentWithFid:fid threadId:self.model.thread_id complete:^(NSString *msg, id responseData) {
        if(![msg strIsNull]&&[msg isEqualToString:@"success"])
        {
            NSArray *array=[NSArray yy_modelArrayWithClass:[WeiboCommentModel class] json:responseData];
            _dataArrs=array;
      
            [self.mainTableView reloadData];
            [self.fullLoadingView close];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

}
-(void)setModelDataWith
{
    [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:self.model.user.avatar_url]];
    [self.nameShowBtn setTitle:self.model.user.screen_name forState:0];
    long long time=[self.model.create_time longLongValue];
    NSDate *timedate=[NSDate dateFromTimeInterval:time];
    NSString *timeStr=[NSDate detailTimeAgoString:timedate];
    self.subShowLable.text=[NSString stringWithFormat:@"%@ . %@",timeStr,self.model.user.verified_content];
    self.contentLable.text=self.model.content;
    self.readcountLable.text=[NSString stringWithFormat:@"%@阅读",[TTWeiboTableViewCell shortShow:self.model.read_count]];
    
    [self createImgCell:self.model.thumb_image_list];

    self.showCommentLable.text=[NSString stringWithFormat:@"评论 %@",self.model.comment_count];
    self.showZangCountLable.text=[NSString stringWithFormat:@"%@ 赞",self.model.digg_count];

}


-(void)removeOldView{
    for (UIView *view in [self.imgView subviews]) {
        if([view isKindOfClass:[UIImageView class]])
        {
      
            [ view removeFromSuperview];
        }
    }
}



-(void)initSubView{
     
    [self.contentView addSubview:self.userTopView];
    [self.userTopView addSubview:self.avatarImgView];
    [self.userTopView addSubview:self.nameShowBtn];
    [self.userTopView addSubview:self.subShowLable];
    [self.contentView addSubview:self.contentLable];
    [self.contentView addSubview:self.readcountLable];
    [self.contentView addSubview:self.fengLineView];
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.showTopView];
    [self.contentView addSubview:self.showTopFengView];
    [self.showTopView addSubview:self.showCommentLable];
    [self.showTopView addSubview:self.showZangCountLable];

    
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.left.equalTo(self.view);
//         make.right.equalTo(self.view);
//         make.top.equalTo(self.view);
//         make.height.equalTo(@500);
//    }];
    
    [self.userTopView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(self.contentView);
          make.right.equalTo(self.contentView);
          make.top.equalTo(self.contentView);
          make.height.equalTo(@60);
    }];
    [self.avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userTopView).offset(15);
        make.size.mas_equalTo(CGSizeMake(36, 36));
        make.top.equalTo(self.userTopView).offset(15);
        
        
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
    
    [self.readcountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImgView);
        make.top.equalTo(self.contentLable.mas_bottom).offset(10);
        
    }];
    
    [self.fengLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 5));
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.readcountLable.mas_bottom).offset(10);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLable.mas_bottom);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@1);
        
    }];
    
    [self.showTopView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.fengLineView.mas_bottom);
         make.left.equalTo(self.contentView);
         make.size.mas_equalTo(CGSizeMake(kScreenWidth, 44));
    }];
    
    [self.showTopFengView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(self.showTopView.mas_bottom);
          make.left.equalTo(self.contentView);
          make.size.mas_equalTo(CGSizeMake(kScreenWidth, 0.5));
    }];
    
    [self.showCommentLable mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.equalTo(self.showTopView);
          make.left.equalTo(self.contentView).offset(15);
        
    }];
    [self.showZangCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.showTopView);
        make.right.equalTo(self.contentView).offset(-15);
        
    }];
    

}


-(void)imgViewClick:(UITapGestureRecognizer*)tapGesture
{
    NSMutableArray *imgLists=[NSMutableArray new];
    for (Large_Image_List *lModel in _model.large_image_list) {
        [imgLists addObject:lModel.url];
    }
  
    
    NSInteger tag=tapGesture.view.tag;
 
    
    TTWeiboShowImageView *ymImageV = [[TTWeiboShowImageView alloc] initWithFrame:[UIScreen mainScreen].bounds byClick:tag-1000 appendArray:imgLists];
    [ymImageV show:self.view didFinish:^(){
        [UIView animateWithDuration:0.3f animations:^{
            ymImageV.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [ymImageV removeFromSuperview];
            
        }];
    }];
    
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
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(lastCell.mas_bottom);
        }];
        
    }else{
        
        
        [self.readcountLable mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImgView);
            make.top.equalTo(self.contentLable.mas_bottom).offset(10);
            
        }];
        
        [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLable.mas_bottom);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@1);
            
        }];
    }
    [self.view layoutIfNeeded];
    
    self.contentView.frame=CGRectMake(0, 0, kScreenWidth, self.showTopFengView.frame.origin.y);
    self.mainTableView.tableHeaderView=self.contentView;
 
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return _dataArrs.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboCommentModel *model=_dataArrs[indexPath.row];
    TTWeiboCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:cellfidf];
    [cell setDataModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboCommentModel *model=_dataArrs[indexPath.row];
   return [tableView fd_heightForCellWithIdentifier:cellfidf cacheByIndexPath:indexPath configuration:^(id cell) {
       [cell setDataModel:model];

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

-(UIView *)userTopView{
    if(!_userTopView){
        _userTopView=[UIView new];

    }
    return _userTopView;
}


-(UIView *)contentView{
    if(!_contentView){
        _contentView=[UIView new];
        
    }
    return _contentView;
}

-(UILabel *)contentLable{
    if(!_contentLable){
        _contentLable=[UILabel new];
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


-(UIView  *)imgView
{
    if(!_imgView){
        _imgView=[UIView new];
        _imgView.backgroundColor=[UIColor clearColor];
    }
    return _imgView;
}


-(UIView *)showTopView{
    if(!_showTopView){
        _showTopView=[UIView new];
    }
    return  _showTopView;
}

-(UIView *)showTopFengView{
    if(!_showTopFengView){
        _showTopFengView=[UIView new];
        _showTopFengView.backgroundColor=[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];

    }
    return  _showTopFengView;
}

-(UILabel*)showCommentLable{
    if(!_showCommentLable){
        _showCommentLable=[UILabel new];
        _showCommentLable.font=[UIFont systemFontOfSize:13];
        _showCommentLable.textColor=[UIColor blackColor];
        
    }
    return _showCommentLable;
}
-(UILabel*)showZangCountLable{
    if(!_showZangCountLable){
        _showZangCountLable=[UILabel new];
        _showZangCountLable.font=[UIFont systemFontOfSize:13];
        _showZangCountLable.textColor=[UIColor blackColor];
        
    }
    return _showZangCountLable;
}




-(UITableView *)mainTableView
{
    if(!_mainTableView){
        self.contentView.frame=CGRectMake(0, 0, kScreenWidth, 100);
        _mainTableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTableView.delegate=self;
        _mainTableView.dataSource=self;
        [_mainTableView registerNib:[UINib nibWithNibName:@"TTWeiboCommentCell" bundle:nil] forCellReuseIdentifier:cellfidf];
        _mainTableView.separatorStyle=NO;
        _mainTableView.tableHeaderView=self.contentView;
    }
    return _mainTableView;
}

-(TTFullScreenLoadingView *)fullLoadingView
{
    if(!_fullLoadingView){
        _fullLoadingView=[TTFullScreenLoadingView new];
        _fullLoadingView.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);

    }
    return _fullLoadingView;
}



//-(WKWebView *)webView{
//    if(!_webView){
//        _webView=[WKWebView new];
//        
//    }
//    return _webView;
//}



@end
