//
//  FeedNewJsonModel.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/4.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <Foundation/Foundation.h>
 

@class FocusonMainModel;
@class WbUser;
@class Forward_Info;
@class Filter_Words;
@class Thumb_Image_List,Url_List;
@class Large_Image_List;
@interface FeedNewJsonModel : NSObject

@property (nonatomic, assign) NSInteger cell_type;
@property (nonatomic, assign) NSInteger cell_layout_style;
@property(nonatomic,strong) FocusonMainModel *raw_data;  // 推荐关注的人数据


// weibo cell
/**
 *  正文内容
 */
@property(nonatomic,strong)NSString  *content;

/**
 *  创建时间
 */
@property(nonatomic,strong)NSNumber  *create_time;

/**
 *  推送时间
 */
@property(nonatomic,strong)NSNumber  *publish_time;


/**
 *  阅读量
 */
@property(nonatomic,strong) NSNumber *read_count;

/**
 *  赞次数
 */
@property(nonatomic,strong) NSNumber *digg_count;


/**
 *  评论次数
 */
@property(nonatomic,strong) NSNumber *comment_count;

/**
 *  用户信息
 */
@property (nonatomic, strong) WbUser *user;


/**
 *  转发次数
 */
@property (nonatomic, strong) Forward_Info *forward_info;


/**
 *  不看的理由
 */
@property (nonatomic, strong) NSArray<Filter_Words *> *filter_words;


/**
 *  小图片列表
 */
@property (nonatomic, strong) NSArray<Thumb_Image_List *> *thumb_image_list;


/**
 *  图片列表
 */
@property (nonatomic, strong) NSArray<Large_Image_List *> *image_list;



/**
 *  高清图列表
 */
@property (nonatomic, strong) NSArray<Large_Image_List *> *large_image_list;


/**
 *  标题
 */
@property(nonatomic,strong) NSString *title;

/**
 *  来源
 */
@property(nonatomic,strong) NSString *source;

/**
 *  置顶类型
 */
@property(nonatomic,strong) NSNumber *label_style;

/**
 *  显示
 */
@property(nonatomic,strong) NSString *label;

/**
 *  用户是否点赞
 */
@property(nonatomic,strong) NSNumber *user_digg;

/**
 *
   cell。id 标示
 */

@property(nonatomic,strong) NSNumber *thread_id;


/**
 *  跳转要取点参数
 */

@property(nonatomic,strong) NSString *schema;

@end



@interface WbUser : NSObject

@property (nonatomic, assign) NSInteger is_blocking;

@property (nonatomic, strong) NSArray *medals;

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, copy) NSString *schema;

@property (nonatomic, assign) NSInteger is_blocked;

@property (nonatomic, assign) NSInteger is_following;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *user_auth_info;

@property (nonatomic, assign) NSInteger is_friend;

@property (nonatomic, assign) long long user_id;

@property (nonatomic, assign) NSInteger user_verified;

@property (nonatomic, copy) NSString *verified_content;

@property (nonatomic, copy) NSString *screen_name;

@end

@interface Forward_Info : NSObject

@property (nonatomic, strong) NSNumber *forward_count;

@end

@interface Filter_Words : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) BOOL is_selected;

@property (nonatomic, copy) NSString *name;

@end

@interface Thumb_Image_List : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, strong) NSArray<Url_List *> *url_list;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *uri;

@end

@interface Url_List : NSObject

@property (nonatomic, copy) NSString *url;

@end

@interface Large_Image_List : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, strong) NSArray<Url_List *> *url_list;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *uri;

@end




