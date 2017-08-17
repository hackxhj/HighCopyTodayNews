//
//  MainTabViewController.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/7/28.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "TTTabBarController.h"
#import "TTTabbar.h"
#import "TTTabBarItem.h"
#import "ArticleTabBarStyleNewsListViewController.h"

@interface TTTabBarController ()<TTTabbarDelegate>
@property(nonatomic,strong)TTTabbar *tttabBar;
@end

@implementation TTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TTTabbar *tttabBar = [[TTTabbar alloc] initWithFrame:self.tabBar.frame];
    tttabBar.ydelegate=self;
    [self setValue:tttabBar forKeyPath:@"tabBar"];
    self.tttabBar=tttabBar;
    [self initTabItems];
    
    
}


-(void)initTabItems{
    
    ArticleTabBarStyleNewsListViewController *homeVC=[ArticleTabBarStyleNewsListViewController new];
 
    UIViewController *watermelonVC=[UIViewController new];
    watermelonVC.view.backgroundColor=[UIColor yellowColor];
    UIViewController *weiheadlineVC=[UIViewController new];
    UIViewController *smallvideoVC=[UIViewController new];
    
    NSArray *viewControllers = @[homeVC, watermelonVC, weiheadlineVC,smallvideoVC];
    NSMutableArray *tabBarVcs = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *viewController = viewControllers[i];
        UINavigationController *navgationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        navgationController.navigationBar.translucent=NO;
        navgationController.navigationBar.barTintColor=[UIColor whiteColor];
       [tabBarVcs addObject:navgationController];
    }
    
    self.viewControllers = tabBarVcs;
 
    
    TTTabBarItem *one1=[[TTTabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"home_tabbar"] selectedImage:[UIImage imageNamed:@"home_tabbar_press"]];
    TTTabBarItem *one2=[[TTTabBarItem alloc]initWithTitle:@"西瓜视频" image:[UIImage imageNamed:@"video_tabbar"] selectedImage:[UIImage imageNamed:@"video_tabbar_press"]];
    TTTabBarItem *one3=[[TTTabBarItem alloc]initWithTitle:@"微头条" image:[UIImage imageNamed:@"weitoutiao_tabbar"] selectedImage:[UIImage imageNamed:@"weitoutiao_tabbar_press"]];
    TTTabBarItem *one4=[[TTTabBarItem alloc]initWithTitle:@"小视频" image:[UIImage imageNamed:@"huoshan_tabbar"] selectedImage:[UIImage imageNamed:@"huoshan_tabbar_press"]];

    self.tttabBar.tabItems=@[one1,one2,one3,one4];
   
    
}


-(void)didSelectedItem:(NSInteger)index{
    self.selectedIndex=index;
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
