//
//  CategoryTitleModel.m
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/1.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "CategoryTitleModel.h"
#import <WCDB/WCDB.h>

@implementation CategoryTitleModel


WCDB_IMPLEMENTATION(CategoryTitleModel)
WCDB_SYNTHESIZE(CategoryTitleModel, category)
WCDB_SYNTHESIZE(CategoryTitleModel, default_add)
WCDB_SYNTHESIZE(CategoryTitleModel, tip_new)
WCDB_SYNTHESIZE(CategoryTitleModel, web_url)
WCDB_SYNTHESIZE(CategoryTitleModel, concern_id)
WCDB_SYNTHESIZE(CategoryTitleModel, icon_url)
WCDB_SYNTHESIZE(CategoryTitleModel, flags)
WCDB_SYNTHESIZE(CategoryTitleModel, type)
WCDB_SYNTHESIZE(CategoryTitleModel, name)
WCDB_PRIMARY(CategoryTitleModel, name)

@end
