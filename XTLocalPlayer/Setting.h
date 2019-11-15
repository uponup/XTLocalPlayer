//
//  Setting.h
//  BookStore
//
//  Created by 龙格 on 2019/7/13.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#ifndef Setting_h
#define Setting_h

#ifdef DEBUG
#define CLog(fmt, ...) NSLog((@"%s [Line: %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define CLog(fmt, ...)
#endif

#pragma mark - 布局
#define kScreen_W [UIScreen mainScreen].bounds.size.width
#define kScreen_H [UIScreen mainScreen].bounds.size.height
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define STATUS_HEIGHT (isPhoneX ? 44 : 20)
#define BOTTOM_BAR_HEIGHT (isPhoneX ? 34 : 0)

#pragma mark - 设备
#define isPhoneX ({\
BOOL iPhoneX = NO;\
if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {\
(iPhoneX);\
}\
if (@available(iOS 11.0, *)) {\
UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];\
if (mainWindow.safeAreaInsets.bottom > 0.0) {\
iPhoneX = YES;\
}\
}\
(iPhoneX);\
})

#pragma mark - 颜色补充
//#338DED
#define GlobalThemeColor [UIColor colorWithRed:51/255.0 green:141/255.0 blue:237/255.0 alpha:1]


#pragma mark - 缓存路径
#define DB_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"XTPlayer.db"]
#define File_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

#endif /* Setting_h */
