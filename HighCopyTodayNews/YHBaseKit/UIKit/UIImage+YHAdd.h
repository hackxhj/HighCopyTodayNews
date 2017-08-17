//
//  UIImage+YHAdd.h
//  YHBaseKit
//
//  Created by hack on 2017/7/27.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIImage (YHAdd)


+ (nullable UIImage *)imageWithEmoji:(NSString *)emoji size:(CGFloat)size;

+ (nullable UIImage *)imageWithColor:(UIColor *)color;

+ (nullable UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (nullable UIImage *)imageByResizeToSize:(CGSize)size;

- (nullable UIImage *)imageByCropToRect:(CGRect)rect;


- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius;


- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor;



- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                                       corners:(UIRectCorner)corners
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor
                                borderLineJoin:(CGLineJoin)borderLineJoin;


@end
NS_ASSUME_NONNULL_END
