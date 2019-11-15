//
//  NSFileManager+Category.m
//  Demo
//
//  Created by upon on 2019/6/6.
//  Copyright © 2019 upon. All rights reserved.
//

#import "NSFileManager+Category.h"
#import <sys/stat.h>

@implementation NSFileManager (Category)

+ (NSNumber *)fileSizWithPath:(NSString *)filePath {
    struct stat statbuf;
    const char *cpath = [filePath fileSystemRepresentation];
    if (cpath && stat(cpath, &statbuf) == 0) {
        NSNumber *fileSize = [NSNumber numberWithUnsignedLongLong:statbuf.st_size];
//        NSDate *modificationDate = [NSDate dateWithTimeIntervalSince1970:statbuf.st_mtime];
//        NSDate *creationDate = [NSDate dateWithTimeIntervalSince1970:statbuf.st_ctime];
        return fileSize;
    }
    return 0;
}

+ (NSDate *)fileCreateDateWithPath:(NSString *)filePath {
    struct stat statbuf;
    const char *cpath = [filePath fileSystemRepresentation];
    if (cpath && stat(cpath, &statbuf) == 0) {
        //        NSDate *modificationDate = [NSDate dateWithTimeIntervalSince1970:statbuf.st_mtime];
        NSDate *creationDate = [NSDate dateWithTimeIntervalSince1970:statbuf.st_ctime];
        return creationDate;
    }
    return 0;
}


@end
