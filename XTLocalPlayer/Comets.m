//
//  Comets.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/16.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "Comets.h"
#import "UIImage+Extend.h"

@interface Comets ()
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *cometColor;
@end

@implementation Comets

#pragma mark - Init Method
- (instancetype)initWithStartPoint:(CGPoint)start andEndPoint:(CGPoint)end {
    return [self initWithStartPoint:start andEndPoint:end andLineColor:[UIColor colorWithHex:0xffffff alpha:0.2] andCometColor:[UIColor colorWithHex:0xffffff]];
}

- (instancetype)initWithStartPoint:(CGPoint)start andEndPoint:(CGPoint)end andLineColor:(UIColor *)lineColor andCometColor:(UIColor *)cometColor {
    self = [super init];
    if (self) {
        _startPoint = start;
        _endPoint = end;
        _lineColor = lineColor;
        _cometColor = cometColor;
        
        self.linePath = [UIBezierPath bezierPath];
        [self.linePath moveToPoint:start];
        [self.linePath addLineToPoint:end];
    }
    return self;
}

- (CAShapeLayer *)drawLine {
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = self.linePath.CGPath;
    lineLayer.lineWidth = 0.5;
    lineLayer.strokeColor = self.lineColor.CGColor;
    return lineLayer;
}

- (CAEmitterLayer *)animate {
    CAEmitterLayer *emit = [CAEmitterLayer layer];
    emit.emitterShape = kCAEmitterLayerPoint;
    emit.emitterPosition = self.startPoint;
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.contents = [self contents];
    
    cell.birthRate = 0.4 * (arc4random() % 1500 + 500) / 1000;
    cell.lifetime = 10.0;
    cell.velocity = 600;
    cell.velocityRange = 400;
    cell.emissionLongitude = [self _calculateAngle];
    
    // add cell to the emitter
    emit.emitterCells = @[cell];
    return emit;
}

#pragma mark - Private Method
- (CGFloat)_calculateAngle {
    CGFloat deltaX = self.endPoint.x - self.startPoint.x;
    CGFloat deltaY = self.endPoint.y - self.startPoint.y;
    return atan2(deltaY, deltaX);
}

#pragma mark -
//Setter
- (void)setLinePath:(UIBezierPath *)linePath {
    _linePath = linePath;
}

// Getter
- (id)contents {
    CAGradientLayer *cometLayer = [CAGradientLayer layer];
    cometLayer.colors = @[(__bridge id)[self.cometColor colorWithAlphaComponent:0.0].CGColor, (__bridge id)self.cometColor.CGColor];
    cometLayer.cornerRadius = 0.25;
    cometLayer.frame = CGRectMake(0, 0, 80, 0.5);
    cometLayer.locations = @[@(0.0), @(1.0)];
    cometLayer.startPoint = CGPointMake(0, 0.5);
    cometLayer.endPoint = CGPointMake(1, 0.5);
    
    
    UIGraphicsBeginImageContextWithOptions(cometLayer.bounds.size, cometLayer.opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context) {
        [cometLayer renderInContext:context];
    }
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [img rotate:[self _calculateAngle]].CGImage;
    
}
@end
