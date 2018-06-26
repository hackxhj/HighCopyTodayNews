//
//  TTBaseNetwork.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

@interface TTBaseNetwork : NSObject
+ (AFHTTPSessionManager *)sharedManager;
+ (void)getURL:(NSString *)subURL parameters:(NSDictionary *)parameters completionHandler:(void (^)(id responseObject))complete;

+ (void)postURL:(NSString *)subURL parameters:(NSDictionary *)parameters completionHandler:(void (^)(id responseObject))complete;


+ (NSString *)resultMessage:(id)responseObject;
+ (id)resultData:(id)responseObject;

@end
