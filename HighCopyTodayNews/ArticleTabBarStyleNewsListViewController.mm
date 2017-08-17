//
//  ArticleTabBarStyleNewsListViewController.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/7/31.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "ArticleTabBarStyleNewsListViewController.h"
#import "TTTopBar.h"
#import "CategoryAddView.h"
#import "TTHomeRequest.h"
#import "NSString+YHAdd.h"
#import "CategoryTitleModel.h"
#import <YYModel/YYModel.h>
#import "ArticleCategoryManagerView.h"
#import "UIApplication+YHAdd.h"
#import <WCDB/WCDB.h>
#import "CategoryTitleModel.h"
#import "TTListShowViewController.h"

@interface ArticleTabBarStyleNewsListViewController ()<CategoryAddViewDelegate>

@property(nonatomic,strong) TTTopBar *topBarView;
@property(nonatomic,strong) CategoryAddView *categoryAdd;
@property(nonatomic,strong) ArticleCategoryManagerView *cateGoryManagerView;
@property(nonatomic,strong) WCTDatabase *database;
@property(nonatomic,strong) UIView *fengLineView;
@end

@implementation ArticleTabBarStyleNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.topBarView];
    [self.view addSubview:self.categoryAdd];
    [self.view addSubview:self.fengLineView];
    CGFloat contentY = CGRectGetMaxY(self.topBarView.frame);
    self.categoryAdd.frame=CGRectMake(kScreenWidth-40, contentY, 40, 40);
    self.fengLineView.frame=CGRectMake(0, contentY+44, kScreenWidth, 0.5);
    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.cateGoryManagerView];
    
    [self initDB];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getCacheData];
    });
  
    
}


-(void)initDB{
 
     NSString *path = [TTDBPath stringByAppendingPathComponent:NSStringFromClass(self.class)];
    _database = [[WCTDatabase alloc] initWithPath:path];
    BOOL ret = [_database createTableAndIndexesOfName:TTCategoryTitleModelMe withClass:CategoryTitleModel.class];
 
}


-(void)getCacheData
{
    NSArray<CategoryTitleModel *> *datas=[_database getObjectsOfClass:CategoryTitleModel.class fromTable:TTCategoryTitleModelMe limit:20];
 
    dispatch_async(dispatch_get_main_queue(), ^{
        if(datas.count!=0)
        {
            NSLog(@"使用缓存！");
            [self setCategoryTitleVC:datas];
            [self.cateGoryManagerView addMeCategory:datas];
        }else{
            [self loadRequest];
        }
    });

}


-(void)loadRequest{
    
    WEAKSELF
    [TTHomeRequest getCategoryTitles:^(NSString *msg, id responseData) {
           if(![msg strIsNull]&&[msg isEqualToString:@"success"])
           {
              NSArray *titlesArr=[NSArray yy_modelArrayWithClass:[CategoryTitleModel class] json:responseData[@"data"]];
              [weakSelf setCategoryTitleVC:titlesArr];
              [weakSelf.cateGoryManagerView addMeCategory:titlesArr];
               
               dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    BOOL result=[_database insertOrReplaceObjects:titlesArr into:TTCategoryTitleModelMe];
               });
    
              NSLog(@"刷新数据！");
           }else{
               NSLog(@"请求失败!");
           }
    }];
    
 
    
}


-(void)setCategoryTitleVC:(NSArray*)resultModel{
    
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];

    CGFloat contentY = CGRectGetMaxY(self.topBarView.frame);
    
    TTListShowViewController *gzVC = [[TTListShowViewController alloc] init];
    gzVC.title = @"关注";
    gzVC.category=gzVC.title;
    [self addChildViewController:gzVC];
    
 
    for (CategoryTitleModel *model in resultModel) {
        TTListShowViewController *addVC = [[TTListShowViewController alloc] init];
        addVC.category=model.category;
        addVC.title = model.name;
        [self addChildViewController:addVC];
    }
    
    
    [self setUpContentViewFrame:^(UIView *contentView) {
        
        CGFloat contentX = 0;
        CGFloat contentH = kScreenHeight - contentY;
        contentView.frame = CGRectMake(contentX, contentY, kScreenWidth, contentH);
        
    }];
    
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        *norColor = [UIColor blackColor];
        *selColor = BaseColor;
        
    }];
    
    [self setUpTitleScale:^(CGFloat *titleScale) {
        *titleScale=1.1;
    }];
    [self refreshDisplay];
    
    [self.view bringSubviewToFront:self.categoryAdd];
    [self.view bringSubviewToFront:self.fengLineView];

}





-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
 }


#pragma  mark  添加分类 点击事件 

-(void)clickAddCategory
{
    [self.cateGoryManagerView show];
}


-(CategoryAddView *)categoryAdd
{
    if(!_categoryAdd){
        _categoryAdd=[CategoryAddView new];
        _categoryAdd.delegate=self;
    }
    return _categoryAdd;
}

-(TTTopBar *)topBarView
{
    if(!_topBarView){
        _topBarView=[TTTopBar new];
        
    }
    return _topBarView;
}

-(ArticleCategoryManagerView *)cateGoryManagerView{
    if(!_cateGoryManagerView){
        _cateGoryManagerView=[ArticleCategoryManagerView new];
    }
    return _cateGoryManagerView;
}
-(UIView *)fengLineView
{
    if(!_fengLineView){
        _fengLineView=[UIView new];
        _fengLineView.backgroundColor=[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
    }
    return _fengLineView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
