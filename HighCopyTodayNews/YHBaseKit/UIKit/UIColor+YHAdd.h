//
//  UIColor+YHAdd.h
//  YHBaseKit
//
//  Created by hack on 2017/7/27.
//  Copyright © 2017年 hack. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]

@interface UIColor (YHAdd)
+ (instancetype)colorWithHexString:(NSString *)hexStr;
+ (instancetype)colorWithIntRed:(int)red intGreen:(int)green intBlue:(int)blue alpha:(float)alpha;
+ (BOOL) isTheSameColor2:(UIColor*)color1 anotherColor:(UIColor*)color2;
@end
