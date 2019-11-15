//
//  UIView+Frame.h
//  BookStore
//
//  Created by 龙格 on 2019/7/13.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

- (void)setCornerRadius:(CGFloat)radius;
- (void)setCornerRadius:(CGFloat)radius position:(UIRectCorner)position;

- (void)addTopBorder:(UIColor *)color;
- (void)addLeftBorder:(UIColor *)color;
- (void)addBottomBorder:(UIColor *)color;
- (void)addRightBorder:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
