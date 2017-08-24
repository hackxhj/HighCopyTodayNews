//
//  ArticleCategoryManagerView.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "ArticleCategoryManagerView.h"
#import "CategoryCollectionReusableView.h"
#import "CategoryMeCollectionViewCell.h"
#import "CategoryAddCollectionViewCell.h"
#import "TTHomeRequest.h"
#import "NSString+YHAdd.h"
#import "CategoryTitleModel.h"
#import <YYModel/YYModel.h>
#import "CategoryCollectionViewFlowLayout.h"
#import "YYFPSLabel.h"
#import <WCDB/WCDB.h>

@interface ArticleCategoryManagerView ()<UICollectionViewDelegate,UICollectionViewDataSource,CategoryCollectionReusableViewDelegate,CategoryMeCollectionViewCellDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong) UIView *frameView;
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UIView *mianCenterView;
@property(nonatomic,strong) UIView *topViewBottomLine;
@property(nonatomic,strong) UIButton *closeBtn;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *dataSourceArr;
@property(nonatomic,strong) NSMutableArray *meTitleArrs;
@property(nonatomic,strong) NSMutableArray *otherTitleArrs;

@property(nonatomic,assign) BOOL isEdit;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property(nonatomic,strong) WCTDatabase *database;

@end

static NSString *const cellIdentf=@"showCellTop";
static NSString *const cellIdentfAdd=@"showCellAdd";
static NSString *const headeridentify=@"headeridentify";


@implementation ArticleCategoryManagerView


-(instancetype)init{
    if(self=[super init]){
         _dataSourceArr=[NSMutableArray new];
         [self initDB];
         [self initSubView];

    }
    return self;
}

-(void)initDB{
    
     NSString *path = [TTDBPath stringByAppendingPathComponent:NSStringFromClass(self.class)];
     _database = [[WCTDatabase alloc] initWithPath:path];
     BOOL ret = [_database createTableAndIndexesOfName:TTCategoryTitleModelOther withClass:CategoryTitleModel.class];
    
}
-(void)getCacheData
{
   NSArray<CategoryTitleModel *> *datas=[_database getObjectsOfClass:CategoryTitleModel.class fromTable:TTCategoryTitleModelOther limit:100];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(datas.count!=0)
        {
            if(_dataSourceArr.count==2){
                [_dataSourceArr removeLastObject];
            }
            [_dataSourceArr addObject:datas];
            [self.collectionView reloadData];
            NSLog(@"使用缓存!");

        }else{
            [self loadRequest];
        }
    });
    
}



-(void)addMeCategory:(NSMutableArray*)meArr{
 
     _otherTitleArrs=[NSMutableArray new];
     _meTitleArrs=meArr;
     [_dataSourceArr addObject:_meTitleArrs];
     [self.collectionView reloadData];
 
}

-(void)loadRequest{
    WEAKSELF
    [TTHomeRequest  getCategoryExtraTitles:^(NSString *msg, id responseData) {
        if(![msg strIsNull]&&[msg isEqualToString:@"success"])
        {
            if(_dataSourceArr.count==2){
                [_dataSourceArr removeLastObject];
            }
           NSArray *titlesArr=[NSArray yy_modelArrayWithClass:[CategoryTitleModel class] json:responseData[@"data"]];
            _otherTitleArrs=[titlesArr mutableCopy];
           [_dataSourceArr addObject:_otherTitleArrs];
           [weakSelf.collectionView reloadData];
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                 
                BOOL result=[_database insertOrReplaceObjects:titlesArr into:TTCategoryTitleModelOther];

             });
            NSLog(@"刷新数据!");

        }else{
            NSLog(@"请求失败!");
        }

    }];
}



-(void)layoutSubviews{
    [super layoutSubviews];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.topView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.topView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.topView.layer.mask = maskLayer;

}

-(void)initSubView{
    
    self.hidden=YES;
    self.frame=CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    UIColor *color = [UIColor blackColor];
    self.backgroundColor=[color colorWithAlphaComponent:0.5];
    [self addSubview:self.frameView];
    [self.frameView addSubview:self.topView];
    [self.frameView addSubview:self.mianCenterView];
    [self.topView addSubview:self.closeBtn];
    [self.mianCenterView addSubview:self.collectionView];
    [self.topView addSubview:self.topViewBottomLine];
   //长按拖动排序手势
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
    [self.collectionView addGestureRecognizer:_longPress];
 
    //添加下拉view手势
    _panGestureRecognizer= [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    _panGestureRecognizer.delegate=self;
    [self.collectionView addGestureRecognizer:_panGestureRecognizer];
    
 
    [self.frameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 44));
        make.top.equalTo(self.frameView);
        make.left.equalTo(self.frameView);
        
    }];
    [self.topViewBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 0.5));
        make.bottom.equalTo(self.topView).offset(-2);
        make.left.equalTo(self.topView);
    }];
    [self.mianCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.topView.mas_bottom).offset(-1);
         make.left.equalTo(self.frameView);
         make.right.equalTo(self.frameView);
         make.bottom.equalTo(self.frameView);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.left.equalTo(self.topView);
        make.top.equalTo(self.topView);
        
    }];
    
 
}
-(void)show
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getCacheData];
    });
    
    [UIView animateWithDuration:0.4// 动画时长
                          delay:0.0 // 动画延迟
         usingSpringWithDamping:0.9 // 类似弹簧振动效果 0~1
          initialSpringVelocity:0.3 // 初始速度
                        options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
                     animations:^{
                         self.hidden=NO;
                         self.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                         self.frameView.frame=CGRectMake(0,20, kScreenWidth, kScreenHeight);
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

-(void)close{
    [UIView animateWithDuration:0.4 animations:^{
        self.frameView.frame=CGRectMake(0,kScreenHeight, kScreenWidth, kScreenHeight);
        self.hidden=YES;
        
    }];
}


-(void)closeAction{
    [self close];
}

#pragma  mark 编辑模式 按钮代理
-(void)clickEditBtn{
    _isEdit=!_isEdit;
    [self.collectionView reloadData];
   
}
#pragma  mark 删除标签 按钮代理

-(void)clickdelAction:(id)sender{
    
    UICollectionViewCell *cell=(UICollectionViewCell *)[sender superview];
    NSIndexPath *indexPath=[self.collectionView indexPathForCell:cell];
    NSMutableArray *extraArr=_dataSourceArr[0];
    [extraArr removeObject:extraArr[indexPath.row]];
    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath  indexPathForRow:indexPath.row inSection:0]]];
}

- (void) handlePan:(UIPanGestureRecognizer*) pan
{
    CGPoint point = [pan translationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan)
    {
    } else if (pan.state == UIGestureRecognizerStateChanged){
        [UIView animateWithDuration:0.3 animations:^{
            self.frameView.frame=CGRectMake(0, point.y, kScreenWidth, kScreenHeight);
        }];
        
    }  else if (pan.state == UIGestureRecognizerStateEnded ||
                pan.state == UIGestureRecognizerStateCancelled ||
                pan.state == UIGestureRecognizerStateFailed)
    {
        if(point.y>200)
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.frameView.frame=CGRectMake(0,kScreenHeight, kScreenWidth, kScreenHeight);
                 self.hidden=YES;
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                 self.hidden=NO;
                  self.frameView.frame=CGRectMake(0,20, kScreenWidth, kScreenHeight);
            }];
        }
    }
    
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
         return NO;
    }
    else {
         return YES;
    }
}

// 给加的手势设置代理, 并实现此协议方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint point = [_panGestureRecognizer translationInView:self];
        //NSLog(@"%f---------：：：%f",point.y,self.collectionView.contentOffset.y);
        //向上拉动的时候  滚动视图没滑动的偏移
        if(point.y > 0.0f && self.collectionView.contentOffset.y <= 0.0f)
        {
            return YES;
        }
    }
    return NO;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGPoint point = [scrollView.panGestureRecognizer translationInView:self];
     if (offsetY <= 0) {
        _topViewBottomLine.hidden=YES;
         self.collectionView.contentOffset=CGPointMake(0, 0);
      
           if(point.y>120)
           {
               [UIView animateWithDuration:0.2 animations:^{
                   self.frameView.frame=CGRectMake(0, point.y, kScreenWidth, kScreenHeight);
               }];
           }
           //NSLog(@"------%f",point.y);
 
    }else{
        _topViewBottomLine.hidden=NO;
    }
 
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self restoreView:scrollView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self restoreView:scrollView];

}

-(void)restoreView:(UIScrollView *)scrollView{
   
    CGPoint point = [scrollView.panGestureRecognizer translationInView:self];
    if(point.y>200){
        self.frameView.frame=CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
        self.hidden=YES;
        
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.hidden=NO;
            self.frameView.frame=CGRectMake(0,20, kScreenWidth, kScreenHeight);
        }];

        
    }
 }


- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress
{
 
    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
     switch (_longPress.state) {
        case UIGestureRecognizerStateBegan: {
            {
                 if(_isEdit&&selectIndexPath.section==0)
                     [_collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
                else{
                     _isEdit=YES;
                     if(selectIndexPath&&selectIndexPath.section==0)
                        [_collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
                    [self.collectionView reloadData];

                 }
              }
            break;
        }
        case UIGestureRecognizerStateChanged: {
 
            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:_longPress.view]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
                [self.collectionView endInteractiveMovement];
            break;
        }
        default: [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath
{
    if(!_isEdit||sourceIndexPath.section==1)
        return;
     // 找到当前的cell
     NSMutableArray *arr=_dataSourceArr[sourceIndexPath.section];
     [arr exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
     [self.collectionView reloadData];
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        CategoryCollectionViewFlowLayout *flowLayout=[[CategoryCollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, 50);//UICollectionView header 的大小
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44-20) collectionViewLayout:flowLayout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor=[UIColor whiteColor];
        [_collectionView registerClass:[CategoryMeCollectionViewCell class] forCellWithReuseIdentifier:cellIdentf];
        [_collectionView registerClass:[CategoryAddCollectionViewCell class] forCellWithReuseIdentifier:cellIdentfAdd];
        [_collectionView registerClass:[CategoryCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headeridentify];//注册头视图

    }
    return _collectionView;
}
#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>

//设置头部自定义视图

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind ==UICollectionElementKindSectionHeader) {
        CategoryCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headeridentify forIndexPath:indexPath];
        if(indexPath.section==0){
            headerView.mainLable.text=@"我的频道";
            headerView.editBtn.hidden=NO;
            if(_isEdit){
                [headerView.editBtn setTitle:@"完成" forState:UIControlStateNormal];
                headerView.subLable.text=@"拖拽可以排序";
             }else{
                [headerView.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
                headerView.subLable.text=@"点击进入频道";
             }
        }else{
            headerView.mainLable.text=@"频道推荐";
            headerView.subLable.text=@"点击添加频道";
            headerView.editBtn.hidden=YES;
         }
        headerView.delegate=self;
        reusableView = headerView;
    }
    if (kind == UICollectionElementKindSectionFooter){
        
    }
    return reusableView;
}


//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataSourceArr.count;
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *arr=_dataSourceArr[section];
    return arr.count;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 10, 5, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat itemWidth = (kScreenWidth - 15 - 20-20) / 4;
    CGFloat itemHeight = AutoHeight(44);
    return CGSizeMake(itemWidth, itemHeight);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        CategoryMeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentf forIndexPath:indexPath];
        NSMutableArray *arr=_dataSourceArr[indexPath.section];
        [cell setMyModel:arr[indexPath.row]];
        cell.delegate=self;
        cell.isEdit=_isEdit;
 
         return cell;
    }else{
        CategoryAddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentfAdd forIndexPath:indexPath];
        NSMutableArray *arr=_dataSourceArr[indexPath.section];
        [cell setMyModel:arr[indexPath.row]];
         return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.section==0){
        
    }else{
        
        NSMutableArray *meArr=_dataSourceArr[0];
        NSMutableArray *extraArr=_dataSourceArr[1];
        [meArr addObject:extraArr[indexPath.row]];
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:meArr.count-1 inSection:0]]];
        [extraArr removeObject:extraArr[indexPath.row]];
        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath  indexPathForRow:indexPath.row inSection:1]]];
     
    }
}
-(UIView *)topView
{
    if(!_topView){
        _topView=[UIView new];
        _topView.backgroundColor=[UIColor whiteColor];
    }
    return _topView;
}
-(UIView *)mianCenterView
{
    if(!_mianCenterView)
    {
        _mianCenterView=[UIView new];
        _mianCenterView.backgroundColor=[UIColor whiteColor];
        
    }
    return _mianCenterView;
}

-(UIButton*)closeBtn{
    if(!_closeBtn){
        _closeBtn=[UIButton new];
        [_closeBtn setImage:[UIImage imageNamed:@"screenshotShare_close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _closeBtn;
}
-(UIView *)frameView
{
    if(!_frameView){
        _frameView=[UIView new];
        _frameView.backgroundColor=[UIColor clearColor];
        
    }
    return _frameView;
}

-(UIView *)topViewBottomLine{
    if(!_topViewBottomLine){
        _topViewBottomLine=[UIView new];
        _topViewBottomLine.hidden=YES;
        _topViewBottomLine.backgroundColor=[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    }
    return _topViewBottomLine;
}


@end

