//
//  MacrocDefine.h
//  YHBaseKit
//
//  Created by hack on 2017/7/27.
//  Copyright © 2017年 hack. All rights reserved.
//

#ifndef MacrocDefine_h
#define MacrocDefine_h


// 屏幕宽高
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kScreenWidth   [UIScreen mainScreen].bounds.size.width

// 按照效果图适应比例 iphone6尺寸
#define AutoWith(x) (x/375.0*[UIScreen mainScreen].bounds.size.width)
#define AutoHeight(x) (x/667.0*[UIScreen mainScreen].bounds.size.height)


// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

//释放定时器
#undef YH_INVALIDATE_TIMER
#define YH_INVALIDATE_TIMER(__TIMER) \
{\
[__TIMER invalidate];\
__TIMER = nil;\
}



#endif /* MacrocDefine_h */
