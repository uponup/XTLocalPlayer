//
//  UIImage+Extend.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/16.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "UIImage+Extend.h"

@implementation UIImage (Extend)

- (UIImage *)rotate:(CGFloat)radians {
    
    CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, radians);
    CGSize newSize = CGSizeApplyAffineTransform(self.size, transform);

    // Trim off the extremely small float value to prevent core graphics from rounding it up
    newSize.width = floor(newSize.width);
    newSize.height = floor(newSize.height);
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    
    // Move origin to middle
    CGContextTranslateCTM(context, newSize.width/2, newSize.height/2);
    // Rotate around middle
    CGContextRotateCTM(context, radians);
    [self drawInRect:CGRectMake(-self.size.width/2, -self.size.height/2, self.size.width, self.size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
