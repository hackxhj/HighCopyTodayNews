//
//  Const.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Const : NSObject


typedef NS_ENUM(NSUInteger, ButtonLoadState) {
    ButtonNormal=0,
    ButtonLoading,
    ButtonUnLoading,
    ButtonComplete,
};

typedef NS_ENUM(NSUInteger, FeedCellStyle) {
     FeedNormalCell=0,
     FeedWeiBoCell=32,
     FeedFocusonCell=50,
    
};


typedef NS_ENUM(NSUInteger, CellLayoutStyle) {
    CellLayputWeiBoCell=9,
 
    
};


//************************** 接口URL ******************************//
extern NSString * TTHostURL;                   // 主地址
extern NSString *const TTVersion_Code;              // 接口版本
extern NSString *const TTVid;
extern NSString *const TTDriveID;
extern NSString *const TTOpenudid;
extern NSString *const TTIdfv;
extern NSString *const TTIid;


extern NSString *const TTCategoryTitlesURL;              // 获取导航分类
extern NSString *const TTCategoryExtra;                 //获取导航标题 扩展
extern NSString *const TTCategoryRecommend;             //获得推荐的关注列表
extern NSString *const TTSearchSuggest;                 //搜索建议
extern NSString *const TTFocusonUser;                   //关注某人
extern NSString *const TTUnFocusonUser;                 //取消关注某人
extern NSString *const TTGetFeedNews;                   //取feed数据
extern NSString *const TTZangWeibo;                     //点赞某条微博
extern NSString *const TTGetWeiboContent;               //获取微博内容的正文数据

extern NSString *const TTCategoryTitleModelMe;
extern NSString *const TTCategoryTitleModelOther;

@end
