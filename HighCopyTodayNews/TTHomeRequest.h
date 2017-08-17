//
//  TTHomeRequest.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "TTBaseNetwork.h"

@interface TTHomeRequest : TTBaseNetwork
/**
 *  获取我的分类标题
 *
 *
 */
+(void)getCategoryTitles :(void (^)(NSString* msg,id responseData))complete;
/**
 *  获取扩展的分类标题
 *
 *
 */
+(void)getCategoryExtraTitles :(void (^)(NSString* msg,id responseData))complete;


/**
 *  获取推荐关注列表
 *
 *  
 */
+(void)getUserRecommendLists:(void (^)(NSString* msg,id responseData))complete;

/**
 *  关注某人
 *
 *  @param userid   要关注人的uid
 *
 */
+(void)setFocusonOnUser :(NSString*)userid complete:(void (^)(NSString* msg,id responseData))complete;

/**
 *  取消关注某人
 *
 *  @param userid   要关注人的uid
 *   
 */
+(void)setUnFocusonOnUser :(NSString*)userid complete:(void (^)(NSString* msg,id responseData))complete;
/**
 *  获取流新闻
 *
 *  @param category 分类
 *
 */
+(void)getFeedNews: (NSString*)category complete:(void (^)(NSString* msg,id responseData))complete;

/**
 *  点赞一条
 *
 *  @param tid      id
 *  @param complete +1
 */
+(void)postZangWeiboWithID:(NSNumber*)tid complete:(void (^)(NSString* msg,id responseData))complete;


/**
 *  获得评论列表
 *
 *  @param fid      fid
 *  @param tid      tid
 *  @param complete +1
 */
+(void)getCommentWithFid:(NSString*)fid threadId:(NSNumber*)tid complete:(void (^)(NSString* msg,id responseData))complete;
/**
 *  获取微博正文内容
 *
 *  @param tid      id
 *  @param complete +1
 */
+(void)weiboGetContent:(NSNumber*)tid complete:(void (^)(NSString* msg,id responseData))complete;
@end
