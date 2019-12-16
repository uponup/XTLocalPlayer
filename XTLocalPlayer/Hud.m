//
//  Hud.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/12/7.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "Hud.h"
#import <SVProgressHUD.h>

@implementation Hud

+ (void)showWithStatus:(NSString *)msg {
    [SVProgressHUD dismiss];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:msg];
    [self dismissWithDelayWithMsg:msg];
}
+ (void)showInfoWithStatus:(NSString *)msg {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showInfoWithStatus:msg];
    [self dismissWithDelayWithMsg:msg];
}
+ (void)showErrorWithStatus:(NSString *)msg {
    [SVProgressHUD showErrorWithStatus:msg];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [self dismissWithDelayWithMsg:msg];
}
+ (void)showSuccessWithStatus:(NSString *)msg {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [Hud showSuccessWithStatus:msg];
    [self dismissWithDelayWithMsg:msg];
}


#pragma mark - Private Method
+ (void)dismissWithDelayWithMsg:(NSString *)msg {
    NSTimeInterval interval = [SVProgressHUD displayDurationForString:msg];
    [SVProgressHUD dismissWithDelay:interval >2.5 ? 2.5 : interval];
}
@end
