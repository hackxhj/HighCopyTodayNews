//
//  CategoryAddView.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/7/31.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CategoryAddViewDelegate <NSObject>

-(void)clickAddCategory;

@end
@interface CategoryAddView : UIView

@property(nonatomic,weak)id<CategoryAddViewDelegate>delegate;
@end
