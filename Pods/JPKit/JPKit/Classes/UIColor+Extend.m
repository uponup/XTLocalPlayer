//
//  UIColor+Extend.m
//  BookStore
//
//  Created by 龙格 on 2019/7/13.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "UIColor+Extend.h"

const NSInteger MAX_RGB_COLOR_VALUE = 0xff;
const NSInteger MAX_RGB_COLOR_VALUE_FLOAT = 255.0f;

@implementation UIColor (Extend)

- (CGFloat)r {
    const CGFloat* rgba = CGColorGetComponents(self.CGColor);
    return rgba[0];
}

- (CGFloat)g {
    const CGFloat* rgba = CGColorGetComponents(self.CGColor);
    return rgba[1];
}

- (CGFloat)b {
    const CGFloat* rgba = CGColorGetComponents(self.CGColor);
    return rgba[2];
}

- (CGFloat)a {
    const CGFloat* rgba = CGColorGetComponents(self.CGColor);
    return rgba[3];
}

- (NSString *) hex {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    NSInteger red = (int)(components[0] * MAX_RGB_COLOR_VALUE);
    NSInteger green = (int)(components[1] * MAX_RGB_COLOR_VALUE);
    NSInteger blue = (int)(components[2] * MAX_RGB_COLOR_VALUE);
    NSInteger alpha = (int)(components[3] * MAX_RGB_COLOR_VALUE);
    
    if (alpha < 255) {
        return [NSString stringWithFormat:@"#%02lx%02lx%02lx%02lx", (long)red, (long)green, (long)blue, (long)alpha];
    }
    
    return [NSString stringWithFormat:@"#%02lx%02lx%02lx", (long)red, (long)green, (long)blue];
}


+ (UIColor *)colorWithHex:(uint)hex {
    return [self colorWithHex:hex alpha:1];
}
+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)a {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000)>>16))/255.0 green:((float)((hex & 0xFF00)>>8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:a];
}

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
}
+ (UIColor *)themeColor {
    return [self colorWithHex:0x1296db];
}
+ (UIColor *)lineColor {
    return [self colorWithHex:0xa9b2bf];
}
+ (UIColor *)lineLightColor {
    return [self colorWithHex:0xa9b2bf alpha:0.76];
}

+ (UIColor *)darkColor {
    return [self colorWithHex:0x000000 alpha:0.87];
}

+ (UIColor *)bgGrayColor {
    return [self colorWithHex:0xf0eff5];
}

@end
