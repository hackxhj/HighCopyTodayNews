//
//  FocusonMainModel.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/4.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <Foundation/Foundation.h>
 

@class FocusonModel;
@interface FocusonMainModel : NSObject

@property (nonatomic, assign) NSInteger has_more;

@property (nonatomic, assign) long long id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *show_more;

@property (nonatomic, copy) NSString *show_more_jump_url;

@property(nonatomic,strong) NSMutableArray<FocusonModel*> *user_cards;

@end
