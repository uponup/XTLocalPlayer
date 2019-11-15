//
//  UIFont+Extend.h
//  BookStore
//
//  Created by 龙格 on 2019/7/13.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (Extend)

+ (UIFont *)font:(CGFloat)fontSize;

+ (UIFont *)normal;
+ (UIFont *)small;
+ (UIFont *)large;
@end

NS_ASSUME_NONNULL_END
