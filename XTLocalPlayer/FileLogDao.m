//
//  FileLogDao.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/15.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "FileLogDao.h"
#import <FMDB.h>

@implementation FileLogDao
static FMDatabaseQueue *_dbQueue;

+ (void)load {
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:DB_PATH];
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = [db executeUpdate:@"create table if not exists xt_localfiles (id integer PRIMARY KEY AUTOINCREMENT, name text, timestamp double, path text, progress float, play_count integer)"];
        if (result) {
            CLog(@"load table xt_localfiles success...");
        } else {
            CLog(@"load table xt_localfiles fail...");
        }
        
    }];
    
    CLog(@"数据库地址： %@", DB_PATH);
}

// 增
+ (void)addFileLog:(FileModel *)model {
    if ([self isExistFileLogWithPath:model.path]) return;
    
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO xt_localfiles (name, timestamp, path, progress, play_count) values ('%@', '%@', '%@', '%@', '%@');", model.name, @(model.timestamp), model.path, @(model.progress), @(model.playCount)];
        BOOL rs = [db executeUpdate:insertSQL];
        if (rs) {
            CLog(@">>>>: 插入成功_%@,", model.name);
        }else {
            CLog(@">>>>: 插入失败_%@,", model.name);
        }
    }];
}

// 删除
+ (void)deleteFileLogs:(NSArray<FileModel *> *)modelArr {
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        for (FileModel *file in modelArr) {
            [db executeUpdate:@"DELETE FROM xt_localfiles WHERE path = ?;", file.path];
        }
    }];
}

// 查
+ (NSArray<FileModel *> *)allFileLogs {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0); //创建信号量
    __block NSMutableArray *fileLogs = [NSMutableArray arrayWithCapacity:0];
    CLog(@"====0");
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sql = @"select * from xt_localfiles";
        
        FMResultSet *rs = [db executeQuery:sql];
        
        while ([rs next]) {
            FileModel *model = [FileModel alloc];
            model.name = [rs stringForColumn:@"name"];
            model.timestamp = [rs doubleForColumn:@"timestamp"];
            model.path = [rs stringForColumn:@"path"];
            model.progress = [rs doubleForColumn:@"progress"];
            model.playCount = [rs intForColumn:@"play_count"];
            [fileLogs addObject:model];
            CLog(@"%@", model);
        }
        CLog(@"====1");
        dispatch_semaphore_signal(semaphore);
    }];
    CLog(@"====2");
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    CLog(@"====3");
    return fileLogs;
}


// 判断FileLog是否存在
+ (BOOL)isExistFileLogWithPath:(NSString *)path {
    __block BOOL hasNext = NO;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *rs = [db executeQuery:@"select * from xt_localfiles where path = ?;", path];
        hasNext = [rs next];
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return hasNext;
}


@end
