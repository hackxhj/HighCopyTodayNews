//
//  FocusonModel.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/3.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FocusonUser,FocusonInfo,FocusonRelation;
@interface FocusonModel : NSObject


@property (nonatomic, strong) FocusonUser *user;

@property (nonatomic, assign) NSInteger recommend_type;

@property (nonatomic, copy) NSString *recommend_reason;

@property (nonatomic, assign) ButtonLoadState loadState;

@end

@interface FocusonUser : NSObject

@property (nonatomic, strong) FocusonInfo *info;

@property (nonatomic, strong) FocusonRelation *relation;

@end

@interface FocusonInfo : NSObject

@property (nonatomic, assign) long long user_id;

@property (nonatomic, copy) NSString *user_auth_info;

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *schema;

@end

@interface FocusonRelation : NSObject

@property (nonatomic, assign) NSInteger is_friend;

@property (nonatomic, assign) NSInteger is_following;

@property (nonatomic, assign) NSInteger is_followed;

@end

