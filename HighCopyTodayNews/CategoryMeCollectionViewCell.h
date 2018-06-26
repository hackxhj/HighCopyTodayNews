//
//  CategoryMeCollectionViewCell.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryTitleModel;

@protocol CategoryMeCollectionViewCellDelegate <NSObject>

-(void)clickdelAction:(id)sender;


@end
@interface CategoryMeCollectionViewCell : UICollectionViewCell
@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic,weak)id<CategoryMeCollectionViewCellDelegate>delegate;
-(void)setMyModel:(CategoryTitleModel*)model;

@end
