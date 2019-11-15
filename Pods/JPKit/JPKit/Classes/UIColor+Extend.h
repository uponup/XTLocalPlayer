//
//  UIColor+Extend.h
//  BookStore
//
//  Created by 龙格 on 2019/7/13.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extend)

// 颜色的属性
@property (nonatomic, assign, readonly) CGFloat r;
@property (nonatomic, assign, readonly) CGFloat g;
@property (nonatomic, assign, readonly) CGFloat b;
@property (nonatomic, assign, readonly) CGFloat a;
@property (nonatomic, copy, readonly) NSString *hex;

+ (UIColor *)colorWithHex:(uint)hex;
+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)a;

+ (UIColor *)randomColor;
+ (UIColor *)themeColor;
+ (UIColor *)lineColor;
+ (UIColor *)lineLightColor;
+ (UIColor *)darkColor;
+ (UIColor *)bgGrayColor;

@end

NS_ASSUME_NONNULL_END
