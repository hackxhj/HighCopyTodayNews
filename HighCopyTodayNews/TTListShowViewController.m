//
//  TTFocusonViewController.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/3.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "TTListShowViewController.h"
#import "FocusonViewCollectionViewCell.h"
#import "TTHomeRequest.h"
#import "FocusonModel.h"
#import <YYModel/YYModel.h>
#import "NSString+YHAdd.h"
#import "FeedFocusonTableViewCell.h"
#import "FeedNewsModel.h"
#import "FeedNewJsonModel.h"
#import "MJRefresh.h"
#import "MJDrawAnimationHeader.h"
#import "TTFullScreenLoadingView.h"
#import "TTWeiboTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "TTWeiboShowImageView.h"
#import "TTLayOutGroupPicCell.h"
#import "TTWeiboDetailsVC.h"

@interface TTListShowViewController ()<UITableViewDelegate,UITableViewDataSource,TTWeiboTableViewCellDelegate>
@property(nonatomic,strong) UITableView *mainTableView;
@property(nonatomic,strong) NSMutableArray *mainDaraArrs;
@property(nonatomic,strong) TTFullScreenLoadingView *fullLoadingView;

@end
static NSString *const cellfocuson=@"cellfocuson";
static NSString *const cellIdentf=@"showCellTop";
static NSString *const headeridentify=@"headeridentify";
static NSString *const defaultcell=@"defaultcell";
static NSString *const cellweiboidentify=@"TTWeiboTableViewCell";
static NSString *const layoutgrouppiccell=@"TTLayOutGroupPicCell";


@implementation TTListShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      _mainDaraArrs=[NSMutableArray array];
      [self loadMainRequest];
      [self.view addSubview:self.mainTableView];
    
    
     [self initSubView];
     [self.mainTableView addSubview:self.fullLoadingView];
    
 
    
}

-(void)initSubView{
    self.mainTableView.mj_header=[MJDrawAnimationHeader headerWithRefreshingBlock:^{
             [self loadMainRequest];
        
    }];
}


-(void)loadMainRequest{
    
    [self.fullLoadingView show];

    [TTHomeRequest getFeedNews:self.category complete:^(NSString *msg, id responseData) {
        if(![msg strIsNull]&&[msg isEqualToString:@"success"])
        {
            [_mainDaraArrs removeAllObjects];

            NSArray *dataArr=[NSArray yy_modelArrayWithClass:[FeedNewsModel class] json:responseData];
            [self buildData:dataArr];
        }
    }];
}


-(void)buildData:(NSArray*)dataArr{
    [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             FeedNewsModel*model=obj;
             FeedNewJsonModel *mainModel=[FeedNewJsonModel yy_modelWithJSON:model.content];
         //    NSLog(@"%@",mainModel);
             [_mainDaraArrs addObject:mainModel];
        
        
    }];
    [self.fullLoadingView close];
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView reloadData];
}




#pragma  mark TTWeiboTableViewCell代理。正文图片点击

-(void)clickImgShow:(NSInteger)tag imgS:(NSArray *)imgs
{

    TTWeiboShowImageView *ymImageV = [[TTWeiboShowImageView alloc] initWithFrame:[UIScreen mainScreen].bounds byClick:tag appendArray:imgs];
    [ymImageV show:self.view didFinish:^(){
         [UIView animateWithDuration:0.3f animations:^{
            ymImageV.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [ymImageV removeFromSuperview];
  
        }];
    }];
}

-(void)zangClick:(id)sender
{
    NSIndexPath *indexPath=[self.mainTableView indexPathForCell:(UITableViewCell*)[[sender superview] superview]];
     FeedNewJsonModel*model=_mainDaraArrs[indexPath.row];
    
    [TTHomeRequest postZangWeiboWithID:model.thread_id complete:^(NSString *msg, id responseData) {
        
        if([responseData[@"err_no"] integerValue]==0){
            model.user_digg=@1;
            model.digg_count=@([model.digg_count longLongValue]+1);
            [self.mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

-(void)clickDetail:(id)sender
{
    NSIndexPath *indexPath=[self.mainTableView indexPathForCell:(UITableViewCell*)[[sender superview] superview]];
    [self pushWithIndexPath:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ self pushWithIndexPath:indexPath.row];
    
}

-(void)pushWithIndexPath:(NSInteger)row{
    FeedNewJsonModel*model=_mainDaraArrs[row];
    if(model.cell_type!=FeedWeiBoCell)
        return;
    TTWeiboDetailsVC *weiboDetail=[TTWeiboDetailsVC new];
    weiboDetail.model=model;
    weiboDetail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:weiboDetail animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UITableView *)mainTableView
{
    if(!_mainTableView){
        _mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height-66-40-49) style:UITableViewStylePlain];
        _mainTableView.delegate=self;
        _mainTableView.dataSource=self;
        _mainTableView.tableFooterView=[UIView new];
        _mainTableView.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
        _mainTableView.separatorStyle=NO;
        [_mainTableView registerClass:[FeedFocusonTableViewCell class] forCellReuseIdentifier:cellfocuson];
        [_mainTableView registerClass:[TTWeiboTableViewCell class] forCellReuseIdentifier:cellweiboidentify];
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:defaultcell];
        [_mainTableView registerClass:[TTLayOutGroupPicCell class] forCellReuseIdentifier:layoutgrouppiccell];
 
    }
    return _mainTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mainDaraArrs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FeedNewJsonModel*model=_mainDaraArrs[indexPath.row];
    if(model.cell_type==FeedFocusonCell)
    {
      FeedFocusonTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellfocuson];
      [cell setDataWithModel:model.raw_data];
      return cell;
    }else if(model.cell_type==FeedWeiBoCell)
    {
        TTWeiboTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellweiboidentify];
        [cell setModelDataWith:model];
        cell.delegate=self;
        return  cell;
    }else if(model.cell_type==FeedNormalCell){
        TTLayOutGroupPicCell *cell=[tableView dequeueReusableCellWithIdentifier:layoutgrouppiccell];
        cell.delegate=self;
        [cell setModelDataWith:model];

        return  cell;
    }
    else{
        UITableViewCell *otherCell=[tableView dequeueReusableCellWithIdentifier:defaultcell];
        return otherCell;
    }
}
 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedNewJsonModel*model=_mainDaraArrs[indexPath.row];
    if(model.cell_type==FeedFocusonCell)
       return 230;
    else if(model.cell_type==FeedWeiBoCell)
    {
         return [tableView fd_heightForCellWithIdentifier:cellweiboidentify cacheByIndexPath:indexPath configuration:^(id cell) {
            [cell setModelDataWith:model];

        }];
       
    }else if(model.cell_type==FeedNormalCell){
        
       
        return [tableView fd_heightForCellWithIdentifier:layoutgrouppiccell cacheByIndexPath:indexPath configuration:^(id cell) {
            [cell setModelDataWith:model];
            
        }];
    }
     else{
       
        return 0;
    }
}


-(TTFullScreenLoadingView *)fullLoadingView
{
    if(!_fullLoadingView){
        _fullLoadingView=[TTFullScreenLoadingView new];
        
    }
    return _fullLoadingView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
