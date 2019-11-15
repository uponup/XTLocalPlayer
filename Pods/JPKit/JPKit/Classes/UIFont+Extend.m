//
//  UIFont+Extend.m
//  BookStore
//
//  Created by 龙格 on 2019/7/13.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "UIFont+Extend.h"

@implementation UIFont (Extend)

+ (UIFont *)font:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)normal {
    return [UIFont font:15];
}
+ (UIFont *)small {
    return [UIFont font:13];
}
+ (UIFont *)large {
    return [UIFont font:17];
}
@end
