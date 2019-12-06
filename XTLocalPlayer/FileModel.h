//
//  FileModel.h
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/15.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FileModel : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, assign) NSTimeInterval timestamp;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) NSInteger playCount;

- (instancetype)initWithName:(NSString *)name andPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
