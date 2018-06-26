//
//  TTWeiboTableViewCell.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/10.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  FeedNewJsonModel;

@protocol TTWeiboTableViewCellDelegate <NSObject>

-(void)clickImgShow:(NSInteger)tag imgS:(NSArray *)imgs;

-(void)zangClick:(id)sender;

-(void)clickDetail:(id)sender;
@optional
-(void)clickImg;


@end
@interface TTWeiboTableViewCell : UITableViewCell

-(void)setModelDataWith:(FeedNewJsonModel*)model;
@property(nonatomic,weak)id<TTWeiboTableViewCellDelegate>delegate;
+(NSString*)shortShow:(NSNumber*)count;
@end
