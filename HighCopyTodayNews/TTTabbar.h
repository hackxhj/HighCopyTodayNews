//
//  TTTabbar.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/7/28.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTTabBarItem;
@protocol TTTabbarDelegate <NSObject>

-(void)didSelectedItem:(NSInteger)index;

@end
@interface TTTabbar : UITabBar
@property(strong, nonatomic) NSArray <TTTabBarItem*> *tabItems;
@property(nonatomic) NSInteger selectedIndex;
@property(nonatomic,weak)id <TTTabbarDelegate> ydelegate;
@end
