//
//  LaunchView.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/16.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "LaunchView.h"
#import "Comets.h"

@implementation LaunchView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.grayColor;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.grayColor;
    }
    return self;
}

#pragma mark - Init UI

- (void)animate {
    CGPoint point_start_1 = CGPointMake(0, 200);
    CGPoint point_end_1 = CGPointMake(200, kScreen_H);

    CGPoint point_start_2 = CGPointMake(0, 280);
    CGPoint point_end_2 = CGPointMake(kScreen_W, kScreen_H-500);

    CGPoint point_start_3 = CGPointMake(kScreen_W, kScreen_H-500);
    CGPoint point_end_3 = CGPointMake(100, kScreen_H);

    CGPoint point_start_4 = CGPointMake(kScreen_W-50, 0);
    CGPoint point_end_4 = CGPointMake(kScreen_W, kScreen_H-200);

    CGPoint point_start_5 = CGPointMake(kScreen_W, 0);
    CGPoint point_end_5 = CGPointMake(0, kScreen_H);

    CGPoint point_start_6 = CGPointMake(0, 0);
    CGPoint point_end_6 = CGPointMake(kScreen_W, kScreen_H);
    
    NSArray *arrStart = @[@(point_start_1), @(point_start_2), @(point_start_3), @(point_start_4), @(point_start_5), @(point_start_6)];
    NSArray *arrEnd = @[@(point_end_1), @(point_end_2), @(point_end_3), @(point_end_4), @(point_end_5), @(point_end_6)];

    
    for (NSInteger i=0; i<6; i++) {
        CGPoint start = [arrStart[i] CGPointValue];
        CGPoint end = [arrEnd[i] CGPointValue];
        Comets *comets = [[Comets alloc]  initWithStartPoint:start andEndPoint:end andLineColor:[UIColor colorWithHex:0xffffff alpha:0.5] andCometColor:UIColor.randomColor];
        [self.layer addSublayer: [comets drawLine]];
        [self.layer addSublayer:[comets animate]];
    }
    
//    [NSThread sleepForTimeInterval:10];
    
//    [self removeFromSuperview];
}

@end
