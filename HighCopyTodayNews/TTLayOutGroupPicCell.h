//
//  TTLayOutGroupPicCell.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/15.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTWeiboTableViewCell.h"

@class  FeedNewJsonModel;

@interface TTLayOutGroupPicCell : UITableViewCell
-(void)setModelDataWith:(FeedNewJsonModel*)model;
@property(nonatomic,weak)id<TTWeiboTableViewCellDelegate>delegate;

@end
