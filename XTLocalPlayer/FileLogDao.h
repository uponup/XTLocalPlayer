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
// 改
+ (void)updatePlayCountWithModel:(FileModel *)fileModel;
// 查
+ (NSArray<FileModel *> *)allFileLogs;
+ (NSArray<FileModel *> *)allHistoryLogs;

@end

NS_ASSUME_NONNULL_END
