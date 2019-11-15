//
//  MavRefreshTableView.h
//  CallPlus
//
//  Created by 龙格 on 2019/10/12.
//  Copyright © 2019 LiuShuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@class MavRefreshTableView;

typedef NS_ENUM(NSInteger, MavRefreshType) {
    MavRefreshType_loadNew = 1 << 0,     //下拉刷新
    MavRefreshType_loadMore = 1 << 1,    //上拉加载
};

@protocol MavRefreshTableViewDelegate <NSObject>

@optional
- (void)refreshTableViewLoadNew:(MavRefreshTableView *)tableView;
- (void)refreshTableViewLoadMore:(MavRefreshTableView *)tableView;
@end

@interface MavRefreshTableView : UITableView

@property (nonatomic, assign) BOOL enableLoadNew;
@property (nonatomic, assign) BOOL enableLoadMore;
@property (nonatomic, assign) id<MavRefreshTableViewDelegate> refreshDelegate;

@end

