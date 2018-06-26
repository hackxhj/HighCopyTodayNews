//
//  FeedFocusonTableViewCell.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/4.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FocusonMainModel.h"

@interface FeedFocusonTableViewCell : UITableViewCell
-(void)setDataWithModel:(FocusonMainModel*)model;
@end
