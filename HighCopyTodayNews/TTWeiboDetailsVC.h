//
//  TTWeiboDetailsVC.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/16.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class FeedNewJsonModel;
@interface TTWeiboDetailsVC : BaseViewController
@property(nonatomic,strong) NSNumber *thread_id;
@property(nonatomic,strong) FeedNewJsonModel *model;

@end
