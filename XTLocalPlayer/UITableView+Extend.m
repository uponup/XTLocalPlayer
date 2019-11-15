//
//  UITableView+Extend.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/15.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "UITableView+Extend.h"

@implementation UITableView (Extend)

- (void)registerCell:(Class)cellClass {
    NSString *identifier = NSStringFromClass(cellClass);
    NSString *path = [[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"];
    if (path) {
        [self registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    }else {
        [self registerClass:cellClass forCellReuseIdentifier:identifier];
    }
}

@end
