//
//  CategoryCollectionReusableView.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryCollectionReusableViewDelegate <NSObject>

-(void)clickEditBtn;

@end
@interface CategoryCollectionReusableView : UICollectionReusableView
@property(nonatomic,strong) UILabel *mainLable;
@property(nonatomic,strong) UILabel *subLable;
@property(nonatomic,strong) UIButton *editBtn;
@property(nonatomic,weak)id<CategoryCollectionReusableViewDelegate> delegate;
@end
