//
//  FeedFocusonTableViewCell.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/4.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "FeedFocusonTableViewCell.h"
#import "FocusonViewCollectionViewCell.h"
#import "TTHomeRequest.h"
#import "NSString+YHAdd.h"
#import <YYModel/YYModel.h>

@interface FeedFocusonTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,FocusonViewCollectionViewCellDelegate>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UIView *recommendView;
@property(nonatomic,strong) NSMutableArray <FocusonModel*>*dataArrs;
@property(atomic,assign) NSInteger loadIndex;
@end

static NSString *const cellIdentf=@"showCellTop";
static NSString *const headeridentify=@"headeridentify";
@implementation FeedFocusonTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
         _dataArrs=[NSMutableArray new];
         [self.contentView addSubview:self.recommendView];
         [self.recommendView addSubview:self.collectionView];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setDataWithModel:(FocusonMainModel*)model{
    _dataArrs=model.user_cards;
    [self.collectionView reloadData];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
 
    if(scrollView.contentOffset.x!=0){
        
        CGFloat itemWidth = (kScreenWidth - 100) / 2;
        // 根据当前的x坐标和页宽度计算出当前页数
        int currentPage = floor((scrollView.contentOffset.x - itemWidth / 2) / itemWidth) + 1;
        if(currentPage+4==_dataArrs.count){
 
            ++_loadIndex;
            [self loadRequestIfNeed];
        }
     }
 }

-(void)loadRequestIfNeed{
   
    if(_loadIndex<=1){
         [self loadRequest];
         NSLog(@"开始请求");

    }
  
    

}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth, 210) collectionViewLayout:flowLayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator=NO;
        [_collectionView registerClass:[FocusonViewCollectionViewCell class] forCellWithReuseIdentifier:cellIdentf];
        
        
    }
    return _collectionView;
}

-(UIView *)recommendView{
    if(!_recommendView){
        _recommendView=[UIView new];
        _recommendView.frame=CGRectMake(0, 0, kScreenWidth, 190+40);
        _recommendView.backgroundColor=[UIColor whiteColor];
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 160, 30)];
        lable.text=@"他们也在用头条";
        lable.font=[UIFont systemFontOfSize:16];
        lable.textColor=[UIColor blackColor];
        [_recommendView addSubview:lable];
        
        UIButton *moreBtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-90, 10, 80, 30)];
        [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        moreBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_recommendView addSubview:moreBtn];
        
    }
    return _recommendView;
}
#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>




//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArrs.count;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat itemWidth = (kScreenWidth - 100) / 2;
    CGFloat itemHeight = 180;
    return CGSizeMake(itemWidth, itemHeight);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    FocusonViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentf forIndexPath:indexPath];
    cell.delegate=self;
    FocusonModel* fmodel=_dataArrs[indexPath.row];
    [cell setUserInfo: fmodel];
    
    return cell;
    
}

 
-(void)onFoucesonClose:(id)sender{
    
    UICollectionViewCell *cell=(UICollectionViewCell *)[sender superview];
    NSIndexPath *indexPath=[self.collectionView indexPathForCell:cell];
    FocusonModel* fmodel=_dataArrs[indexPath.row];
    [_dataArrs removeObject:fmodel];
    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath  indexPathForRow:indexPath.row inSection:0]]];

}

-(void)onFoucesonUser:(id)sender{
    UICollectionViewCell *cell=(UICollectionViewCell *)[sender superview];
    NSIndexPath *indexPath=[self.collectionView indexPathForCell:cell];
    FocusonModel* fmodel=_dataArrs[indexPath.row];
    if(fmodel.loadState==ButtonNormal)
    {
        [self focuSonrequest:[NSString stringWithFormat:@"%lld",fmodel.user.info.user_id] indexPath:indexPath];
        fmodel.loadState=ButtonLoading;
        
    }else if(fmodel.loadState==ButtonComplete){
        [self unfocuSonrequest:[NSString stringWithFormat:@"%lld",fmodel.user.info.user_id] indexPath:indexPath];
        fmodel.loadState=ButtonUnLoading;
        
    }
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath  indexPathForRow:indexPath.row inSection:0]]];
    
    
    
}


-(void)focuSonrequest:(NSString*)userID indexPath:(NSIndexPath*)indexPath{
    
    [TTHomeRequest setFocusonOnUser:userID complete:^(NSString *msg, id responseData) {
        if(![msg strIsNull]&&[msg isEqualToString:@"success"])
        {
            FocusonModel* fmodel=_dataArrs[indexPath.row];
            fmodel.loadState=ButtonComplete;
            [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath  indexPathForRow:indexPath.row inSection:0]]];
            if(indexPath.row<_dataArrs.count-3){
                 NSIndexPath *lastIndex=[NSIndexPath indexPathForRow:indexPath.row+2 inSection:0];
                 [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            }
        }
    }];
    
}

-(void)unfocuSonrequest:(NSString*)userID indexPath:(NSIndexPath*)indexPath{
    
    [TTHomeRequest setUnFocusonOnUser:userID complete:^(NSString *msg, id responseData) {
        if(![msg strIsNull]&&[msg isEqualToString:@"success"])
        {
            FocusonModel* fmodel=_dataArrs[indexPath.row];
            fmodel.loadState=ButtonNormal;
            [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath  indexPathForRow:indexPath.row inSection:0]]];
            
        }
    }];
    
}
-(void)loadRequest{
    [TTHomeRequest getUserRecommendLists:^(NSString *msg, id responseData) {
        if([msg isEqualToString:@"0"]){
            NSArray<FocusonModel*> *datas=[NSArray yy_modelArrayWithClass:[FocusonModel class] json:responseData[@"user_cards"]];
            [_dataArrs addObjectsFromArray:datas];
            [self.collectionView reloadData];
            NSLog(@"加载数据");
            _loadIndex=0;
        }
    }];
}

@end
