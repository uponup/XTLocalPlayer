//
//  FileLogDao.h
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/15.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileLogDao : NSObject

// 增
+ (void)addFileLog:(FileModel *)model;
// 删除
+ (void)deleteFileLogs:(NSArray<FileModel *> *)modelArr;
// 查
+ (NSArray<FileModel *> *)allFileLogs;

@end

NS_ASSUME_NONNULL_END
