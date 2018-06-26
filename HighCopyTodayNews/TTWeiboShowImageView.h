//
//  TTWeiboShowImageView.h
//  HighCopyTodayNews
//
//  Created by hack on 2017/8/14.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^didRemoveImage)(void);

@interface TTWeiboShowImageView : UIView<UIScrollViewDelegate>
{
    UIImageView *showImage;

}

@property (nonatomic,copy) didRemoveImage removeImg;

- (void)show:(UIView *)bgView didFinish:(didRemoveImage)tempBlock;

- (id)initWithFrame:(CGRect)frame byClick:(NSInteger)clickTag appendArray:(NSArray *)appendArray;
@end
