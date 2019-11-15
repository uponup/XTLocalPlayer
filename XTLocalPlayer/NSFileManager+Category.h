//
//  NSFileManager+Category.h
//  Demo
//
//  Created by upon on 2019/6/6.
//  Copyright © 2019 upon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (Category)

// 这样获取文件大小，比起原生方法attributesOfItemAtPath快了0.000020秒
+ (NSNumber *)fileSizWithPath:(NSString *)filePath;
+ (NSDate *)fileCreateDateWithPath:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
