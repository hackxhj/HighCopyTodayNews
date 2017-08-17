//
//  TTWeiboCommentCell.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/17.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiboCommentModel;

@interface TTWeiboCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *txImg;
@property (weak, nonatomic) IBOutlet UIButton *nameShow;
@property (weak, nonatomic) IBOutlet UILabel *zangCountLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UILabel *timeShowLable;

-(void)setDataModel:(WeiboCommentModel*)model;
@end
