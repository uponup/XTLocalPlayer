//
//  MavRefreshTableView.m
//  CallPlus
//
//  Created by 龙格 on 2019/10/12.
//  Copyright © 2019 LiuShuo. All rights reserved.
//

#import "MavRefreshTableView.h"

@implementation MavRefreshTableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setEnableLoadNew:(BOOL)enableLoadNew {
    if (enableLoadNew) {
        [self createHeaderView];
    }else {
        [self removeHeaderView];
    }
}

- (void)setEnableLoadMore:(BOOL)enableLoadMore {
    if (enableLoadMore) {
        [self createFooterView];
    }else {
        [self removeFooterView];
    }
}

#pragma mark - Private Method
- (void)createHeaderView {
    if (!self.mj_header) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    }
}

- (void)removeHeaderView {
    if (self.mj_header) {
        self.mj_header = nil;
    }
}

- (void)createFooterView {
    if (!self.mj_footer) {
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    }
}

- (void)removeFooterView {
    if (self.mj_footer) {
        self.mj_footer = nil;
    }
}

- (void)loadNew {
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(refreshTableViewLoadNew:)]) {
        [self.refreshDelegate refreshTableViewLoadNew:self];
    }
}

- (void)loadMore {
    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(refreshTableViewLoadMore:)]) {
        [self.refreshDelegate refreshTableViewLoadMore:self];
    }
}

@end
