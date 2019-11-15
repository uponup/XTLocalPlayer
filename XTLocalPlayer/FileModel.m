//
//  FileModel.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/15.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "FileModel.h"

@implementation FileModel

- (instancetype)initWithName:(NSString *)name andPath:(NSString *)path {
    self = [super init];
    if (self) {
        _name = name;
        _path = path;
        _timestamp = [[NSDate date] timeIntervalSince1970];
        _playCount = 0;
        _progress = 0.0;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, 播放次数：%@, 上次进度：%@，本地路径：%@", self.name, @(self.playCount), @(self.progress), self.path];
    return @"";
}

@end
