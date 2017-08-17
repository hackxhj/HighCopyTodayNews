//
//  YHButton.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/10.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (Layout)

@property (nonatomic,assign) CGRect titleRect;
@property (nonatomic,assign) CGRect imageRect;

@end


@interface YHButton : UIButton
@property (nonatomic,assign) CGRect titleRect;
@property (nonatomic,assign) CGRect imageRect;
@end
