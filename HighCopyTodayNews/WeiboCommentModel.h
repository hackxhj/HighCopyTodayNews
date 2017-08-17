//
//  WeiboCommentModel.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/17.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Comment,Media_Info;
@interface WeiboCommentModel : NSObject


@property (nonatomic, assign) NSInteger cell_type;

@property (nonatomic, strong) Comment *comment;

@end
@interface Comment : NSObject

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, strong) Media_Info *media_info;

@property (nonatomic, assign) NSInteger is_followed;

@property (nonatomic, assign) NSInteger user_bury;

@property (nonatomic, assign) NSInteger create_time;

@property (nonatomic, assign) long long user_id;

@property (nonatomic, assign) NSInteger digg_count;

@property (nonatomic, assign) NSInteger reply_count;

@property (nonatomic, assign) CGFloat score;

@property (nonatomic, assign) NSInteger bury_count;

@property (nonatomic, assign) BOOL user_verified;

@property (nonatomic, copy) NSString *user_auth_info;

@property (nonatomic, strong) NSArray *author_badge;

@property (nonatomic, strong) NSArray *reply_list;

@property (nonatomic, copy) NSString *verified_reason;

@property (nonatomic, assign) NSInteger is_pgc_author;

@property (nonatomic, assign) long long id;

@property (nonatomic, copy) NSString *platform;

@property (nonatomic, assign) NSInteger user_relation;

@property (nonatomic, assign) NSInteger user_digg;

@property (nonatomic, assign) NSInteger is_blocking;

@property (nonatomic, assign) NSInteger is_following;

@property (nonatomic, copy) NSString *user_profile_image_url;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSInteger is_blocked;

@end

@interface Media_Info : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *avatar_url;

@end

