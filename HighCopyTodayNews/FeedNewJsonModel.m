//
//  FeedNewJsonModel.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/4.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "FeedNewJsonModel.h"

@implementation FeedNewJsonModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"filter_words" : [Filter_Words class],
             @"thumb_image_list" : [Thumb_Image_List class],
             @"large_image_list" : [Large_Image_List class],
             @"image_list" : [Large_Image_List class]};
}


@end
@implementation WbUser

@end


@implementation Forward_Info

@end


@implementation Filter_Words

@end


@implementation Thumb_Image_List

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"url_list" : [Url_List class]};
}

@end


@implementation Url_List

@end


@implementation Large_Image_List

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"url_list" : [Url_List class]};
}

@end


 

