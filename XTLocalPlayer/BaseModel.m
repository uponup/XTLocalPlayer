//
//  BaseModel.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/15.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel 

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar *list = class_copyIvarList(self.class, &count);
    for (int i=0; i<count; i++) {
        //先获取key
        Ivar tempIvar = list[i];
        NSString *keyName = [NSString stringWithUTF8String:ivar_getName(tempIvar)];
        //归档
        id value = [self valueForKey:keyName];
        if (value) {
            [aCoder encodeObject:value forKey:keyName];
        }
    }
    free(list);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar *list = class_copyIvarList(self.class, &count);
        for (int i=0; i<count; i++) {
            //先获取key
            Ivar tempIvar = list[i];
            NSString *keyName = [NSString stringWithUTF8String:ivar_getName(tempIvar)];
            //解档
            id value = [aDecoder decodeObjectForKey:keyName];
            if (value) {
                [self setValue:value forKey:keyName];
            }
        }
        free(list);
    }
    return self;
}
@end
