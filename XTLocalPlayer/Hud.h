//
//  Hud.h
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/12/7.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hud : NSObject

+ (void)showWithStatus:(NSString *)msg;
+ (void)showInfoWithStatus:(NSString *)msg;
+ (void)showErrorWithStatus:(NSString *)msg;
+ (void)showSuccessWithStatus:(NSString *)msg;


@end

NS_ASSUME_NONNULL_END
