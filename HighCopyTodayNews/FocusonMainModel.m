//
//  FocusonMainModel.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/4.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "FocusonMainModel.h"
#import "FocusonModel.h"
@implementation FocusonMainModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"user_cards" : [FocusonModel class]
         };
}
@end
