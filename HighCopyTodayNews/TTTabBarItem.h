//
//  TTTabBarItem.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/7/28.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTTabBarItem : UIButton

@property(strong, nonatomic) UILabel *showTitleLable;
@property(copy, nonatomic)   NSString *title;
@property(strong, nonatomic) UIImage *loadingImage;
@property(strong, nonatomic) UIImage *highlightedImage;
@property(strong, nonatomic) UIImage *noralImage;
@property(strong, nonatomic) UIImageView *iconImgView;
@property(nonatomic)BOOL itemSelected;
-(instancetype)initWithTitle:(NSString*)title image:(UIImage*)image selectedImage:(UIImage*)selectImg;
 @end
