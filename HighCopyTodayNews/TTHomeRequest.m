//
//  TTHomeRequest.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "TTHomeRequest.h"

@implementation TTHomeRequest

+(void)getCategoryTitles :(void (^)(NSString* msg,id responseData))complete
{
    NSDictionary *rootPram=@{@"version_code":TTVersion_Code,@"app_name":@"news_article",@"vid":TTVid,@"device_id":TTDriveID,@"channel":@"pp",@"openudid":TTOpenudid,@"idfv":TTIdfv};
    
    [self getURL:TTCategoryTitlesURL parameters:rootPram completionHandler:^(id responseObject) {
        
        if(complete){
            complete([self resultMessage:responseObject],[self resultData:responseObject]);
        }
    }];
}

+(void)getCategoryExtraTitles :(void (^)(NSString* msg,id responseData))complete
{
    NSDictionary *rootPram=@{@"version_code":TTVersion_Code,@"app_name":@"news_article",@"vid":TTVid,@"device_id":TTDriveID,@"channel":@"pp",@"openudid":TTOpenudid,@"idfv":TTIdfv};
    
    [self getURL:TTCategoryExtra parameters:rootPram completionHandler:^(id responseObject) {
        
        if(complete){
            complete([self resultMessage:responseObject],[self resultData:responseObject]);
        }
    }];
}

+(void)getUserRecommendLists:(void (^)(NSString* msg,id responseData))complete
{
    NSDictionary *rootPram=@{@"version_code":TTVersion_Code,@"app_name":@"news_article",@"vid":TTVid,@"device_id":TTDriveID,@"channel":@"pp",@"openudid":TTOpenudid,@"idfv":TTIdfv,@"iid":TTIid};
    
    [self getURL:TTCategoryRecommend parameters:rootPram completionHandler:^(id responseObject) {
        
        if(complete){
            complete([NSString stringWithFormat:@"%@",responseObject[@"err_no"]],responseObject);
        }
    }];
}

+(void)setFocusonOnUser :(NSString*)userid complete:(void (^)(NSString* msg,id responseData))complete
{
    NSDictionary *rootPram=@{@"version_code":TTVersion_Code,@"app_name":@"news_article",@"vid":TTVid,@"device_id":TTDriveID,@"channel":@"pp",@"openudid":TTOpenudid,@"idfv":TTIdfv,@"iid":TTIid,@"user_id":userid};
    
    [self getURL:TTFocusonUser parameters:rootPram completionHandler:^(id responseObject) {
        
        if(complete){
            complete([self resultMessage:responseObject],[self resultData:responseObject]);
        }
    }];
}

+(void)setUnFocusonOnUser :(NSString*)userid complete:(void (^)(NSString* msg,id responseData))complete
{
    NSDictionary *rootPram=@{@"version_code":TTVersion_Code,@"app_name":@"news_article",@"vid":TTVid,@"device_id":TTDriveID,@"channel":@"pp",@"openudid":TTOpenudid,@"idfv":TTIdfv,@"iid":TTIid,@"user_id":userid};
    
    [self getURL:TTUnFocusonUser parameters:rootPram completionHandler:^(id responseObject) {
        
        if(complete){
            complete([self resultMessage:responseObject],[self resultData:responseObject]);
        }
    }];
}

+(void)getFeedNews: (NSString*)category complete:(void (^)(NSString* msg,id responseData))complete
{
    NSDictionary *rootPram=@{@"version_code":TTVersion_Code,@"app_name":@"news_article",@"vid":TTVid,@"device_id":TTDriveID,@"channel":@"pp",@"openudid":TTOpenudid,@"idfv":TTIdfv,@"iid":TTIid,@"category":category};
    
    [self getURL:TTGetFeedNews parameters:rootPram completionHandler:^(id responseObject) {
        
        if(complete){
            complete([self resultMessage:responseObject],[self resultData:responseObject]);
        }
    }];
}

+(void)postZangWeiboWithID:(NSNumber*)tid complete:(void (^)(NSString* msg,id responseData))complete
{
    NSString *url=@"ttdiscuss/v1/commit/threaddigg/?version_code=6.2.6&app_name=news_article&vid=3678164C-BC97-4BDE-90C3-3796BF8C39DA&device_id=3002398707&channel=pp&resolution=750*1334&aid=13&ab_version=156443,151232,162228,157072,158954,159259,151123,156285,157001,158289,161099,162399,134127,162410,159897,162333,161388,161180,152027,125174,162233,162572,158910,161014,156262,157857,160810,157295,31651,133013,131207,145585,156141,161614,161721,151116&ab_feature=z2&ab_group=z2&openudid=5f892e162435cdbae5dc2856c69bb9ecbc678040&live_sdk_version=1.6.5&idfv=3678164C-BC97-4BDE-90C3-3796BF8C39DA&ac=WIFI&os_version=9.3.3&ssmix=a&device_platform=iphone&iid=12374638189&ab_client=a1,f2,f7,e1&device_type=iPhone%206&idfa=42BF50BF-CB86-455C-A060-2064250629FE";
    
    NSDictionary *rootPram=@{@"thread_id":tid};

    [self postURL:url parameters:rootPram completionHandler:^(id responseObject) {
        
        if(complete){
            complete(@"",responseObject);
        }
    }];
}

+(void)getCommentWithFid:(NSString*)fid threadId:(NSNumber*)tid complete:(void (^)(NSString* msg,id responseData))complete
{
    NSString *url=@"/article/v2/tab_comments/?version_code=6.2.6&app_name=news_article&vid=3678164C-BC97-4BDE-90C3-3796BF8C39DA&device_id=3002398707&channel=pp&resolution=750*1334&aid=13&ab_version=162694,151232,162228,157072,158954,159259,151123,156285,157001,158289,161099,162399,134127,163083,159897,162743,161388,152027,125174,162233,162572,158910,161014,156262,162707,160810,157295,31651,133013,131207,145585,162704,156141,161614,161721,151116&ab_feature=z2&ab_group=z2&openudid=5f892e162435cdbae5dc2856c69bb9ecbc678040&live_sdk_version=1.6.5&idfv=3678164C-BC97-4BDE-90C3-3796BF8C39DA&ac=WIFI&os_version=9.3.3&ssmix=a&device_platform=iphone&iid=12374638189&ab_client=a1,f2,f7,e1&device_type=iPhone%206&idfa=EC13E480-98ED-423A-A41E-B8D683EA2CB";
    
    NSDictionary *rootPram=@{@"count":@20,@"forum_id":fid,@"group_id":tid,@"group_type":@2,@"item_id":@0,@"offset":@0};
    
    [self postURL:url parameters:rootPram completionHandler:^(id responseObject) {
        
        if(complete){
            complete([self resultMessage:responseObject],[self resultData:responseObject]);
        }
    }];
}



+(void)weiboGetContent:(NSNumber*)tid complete:(void (^)(NSString* msg,id responseData))complete
{
    NSDictionary *rootPram=@{@"version_code":TTVersion_Code,@"app_name":@"news_article",@"vid":TTVid,@"device_id":TTDriveID,@"channel":@"pp",@"openudid":TTOpenudid,@"idfv":TTIdfv,@"iid":TTIid,@"thread_id":tid};
    
    [self getURL:TTGetWeiboContent parameters:rootPram completionHandler:^(id responseObject) {
        
        if(complete){
            complete(@"",responseObject);
        }
    }];
}
@end
