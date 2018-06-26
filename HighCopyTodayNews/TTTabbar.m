//
//  TTTabbar.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/7/28.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "TTTabbar.h"
#import "TTTabBarItem.h"

@interface TTTabbar ()
@property(nonatomic,strong) UIImageView *topFengImg;

@end

@implementation TTTabbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame])
    {
        self.translucent=NO;
        self.barTintColor=[UIColor colorWithRed:0.98 green:0.98 blue:0.97 alpha:1];
      //  [self addSubview:self.topFengImg];
     }
    return self;
}
-(void)clearView{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

-(void)setTabItems:(NSArray *)tabItems{

    _selectedIndex=1000;
    _tabItems=tabItems;
    [self clearView];
    for (int i=0; i<tabItems.count; i++) {
        
        TTTabBarItem *barItem=tabItems[i];
        barItem.tag=i+1000;
        [barItem addTarget:self action:@selector(onClickItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:barItem];

    }
    [self setSelectedIndex:_selectedIndex];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setupTabBarItems];
}

-(void)onClickItem:(UIButton*)sender{
     if([self.ydelegate respondsToSelector:@selector(didSelectedItem:)])
     {
         [self.ydelegate didSelectedItem:sender.tag-1000];
     }
    
    self.selectedIndex=sender.tag;
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    
     TTTabBarItem *barItemOldSelect=(TTTabBarItem *)[self viewWithTag:_selectedIndex];
     barItemOldSelect.itemSelected=NO;
        
     TTTabBarItem *barItemNewSelect=(TTTabBarItem *)[self viewWithTag:selectedIndex];
     barItemNewSelect.itemSelected=YES;
     _selectedIndex=selectedIndex;
   
}




- (void)setupTabBarItems
{
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    int count = (int)self.tabItems.count;
    CGFloat itemY = 0;
    CGFloat itemW = w / count;
    CGFloat itemH = h;
    
    for (int index = 0; index < count; index++) {
        
        TTTabBarItem *tabBarItem = self.tabItems[index];
        CGFloat itemX = index * itemW;
        tabBarItem.frame = CGRectMake(itemX, itemY, itemW, itemH);
    }
}

-(UIImageView *)topFengImg
{
    if(!_topFengImg){
        _topFengImg=[UIImageView new];
        _topFengImg.backgroundColor=[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
        _topFengImg.frame=CGRectMake(0, 0,self.frame.size.width, 0.5);

    }
    return _topFengImg;
}

@end
