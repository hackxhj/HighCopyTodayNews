//
//  LoadingButton.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/4.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LoadingButton : UIButton
@property(nonatomic,strong) UIImageView *loadingImg;
@property(nonatomic,assign) ButtonLoadState  loadState;
@end
