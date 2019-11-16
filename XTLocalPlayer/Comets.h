//
//  Comets.h
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/16.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Comets : NSObject

@property (nonatomic, strong) UIBezierPath *linePath;

- (instancetype)initWithStartPoint:(CGPoint)start andEndPoint:(CGPoint)end;
- (instancetype)initWithStartPoint:(CGPoint)start andEndPoint:(CGPoint)end andLineColor:(UIColor *)lineColor andCometColor:(UIColor *)cometColor;

- (CAShapeLayer *)drawLine;
- (CAEmitterLayer *)animate;

@end

NS_ASSUME_NONNULL_END
