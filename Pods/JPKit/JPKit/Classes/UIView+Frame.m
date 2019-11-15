//
//  UIView+Frame.m
//  BookStore
//
//  Created by 龙格 on 2019/7/13.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)value {
    CGRect frame = self.frame;
    frame.origin.x = value;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)value {
    CGRect frame = self.frame;
    frame.origin.y = value;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setCornerRadius:(CGFloat)radius{
    [self setCornerRadius:radius position:UIRectCornerAllCorners];
}

- (void)setCornerRadius:(CGFloat)radius position:(UIRectCorner)position{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:position cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

- (void)addTopBorder:(UIColor *)color {
    CALayer *borderLayer = [CALayer layer];
    borderLayer.frame = CGRectMake(0, 0, self.width, 0.5);
    borderLayer.backgroundColor = color.CGColor;
    [self.layer addSublayer:borderLayer];
}

- (void)addLeftBorder:(UIColor *)color {
    CALayer *borderLayer = [CALayer layer];
    borderLayer.frame = CGRectMake(0, 0, 0.5, self.height);
    borderLayer.backgroundColor = color.CGColor;
    [self.layer addSublayer:borderLayer];
}

- (void)addBottomBorder:(UIColor *)color {
    CALayer *borderLayer = [CALayer layer];
    borderLayer.frame = CGRectMake(0, self.height-0.5, self.width, 0.5);
    borderLayer.backgroundColor = color.CGColor;
    [self.layer addSublayer:borderLayer];
}

- (void)addRightBorder:(UIColor *)color {
    CALayer *borderLayer = [CALayer layer];
    borderLayer.frame = CGRectMake(self.width-0.5, 0, 0.5, self.height);
    borderLayer.backgroundColor = color.CGColor;
    [self.layer addSublayer:borderLayer];
}

@end
