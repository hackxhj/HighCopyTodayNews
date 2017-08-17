//
//  UIView+YHFrameKit.m
//  YHBaseKit
//
//  Created by hack on 2017/7/27.
//  Copyright © 2017年 hack. All rights reserved.
//

#import "UIView+YHAdd.h"

@implementation UIView (YHAdd)
- (void)setYh_x:(CGFloat)yh_x
{
    CGRect frame = self.frame;
    frame.origin.x = yh_x;
    self.frame = frame;
}

- (CGFloat)yh_x
{
    return self.frame.origin.x;
}

- (void)setYh_y:(CGFloat)yh_y
{
    CGRect frame = self.frame;
    frame.origin.y = yh_y;
    self.frame = frame;
}

- (CGFloat)yh_y
{
    return self.frame.origin.y;
}

- (void)setYh_w:(CGFloat)yh_w
{
    CGRect frame = self.frame;
    frame.size.width = yh_w;
    self.frame = frame;
}

- (CGFloat)yh_w
{
    return self.frame.size.width;
}

- (void)setYh_h:(CGFloat)yh_h
{
    CGRect frame = self.frame;
    frame.size.height = yh_h;
    self.frame = frame;
}

- (CGFloat)yh_h
{
    return self.frame.size.height;
}

- (void)setYh_size:(CGSize)yh_size
{
    CGRect frame = self.frame;
    frame.size = yh_size;
    self.frame = frame;
}

- (CGSize)yh_size
{
    return self.frame.size;
}

- (void)setYh_origin:(CGPoint)yh_origin
{
    CGRect frame = self.frame;
    frame.origin = yh_origin;
    self.frame = frame;
}

- (CGPoint)yh_origin
{
    return self.frame.origin;
}
@end
