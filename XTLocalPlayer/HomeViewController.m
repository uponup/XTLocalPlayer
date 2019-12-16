//
//  HomeViewController.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/14.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "HomeViewController.h"
#import "TransportViewController.h"
#import "AudioDetailController.h"
#import "AboutViewController.h"

#import "VideoCell.h"
#import "UITableView+Extend.h"


@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSInteger _currentIndex;    // 当前标签：0，本地视频，1，历史记录
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLocalBtnCenter;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *sliderBlockView;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;      
@property (weak, nonatomic) IBOutlet UIView *nodataView;

@property (nonatomic, strong) NSMutableArray *localArr;
@property (nonatomic, strong) NSMutableArray *historyArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerCell:[VideoCell class]];
}

#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self refreshData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Click Action

- (IBAction)uploadButtonAction:(id)sender {
    TransportViewController *transportVc = [TransportViewController new];
    [self.navigationController pushViewController:transportVc animated:YES];
}

- (IBAction)deleteButtonAction:(id)sender {
    // todo delete
    
}
- (IBAction)settingAction:(id)sender {
    AboutViewController *aboutVc = [AboutViewController new];
    [self.navigationController pushViewController:aboutVc animated:YES];
}

- (IBAction)localButtonAction:(id)sender {
    _currentIndex = 0;
    [UIView animateWithDuration:0.27 animations:^{
        self.layoutLocalBtnCenter.constant = 0;
        [self.view layoutIfNeeded];
    }];
    _currentIndex = 0;
    [self refreshData];
}

- (IBAction)historyButtonAction:(id)sender {
    _currentIndex = 1;
    [UIView animateWithDuration:0.27 animations:^{
        self.layoutLocalBtnCenter.constant = kScreen_W/2;
        [self.view layoutIfNeeded];
    }];
    _currentIndex = 1;
    [self refreshData];
}

#pragma mark - UITableViewDelegate && UITableViewDataSources
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_currentIndex == 0) {
        self.btnAdd.hidden = NO;
        self.nodataView.hidden = self.localArr.count != 0;
        self.tableView.hidden = self.localArr.count == 0;
        return self.localArr.count;
    }else {
        self.btnAdd.hidden = YES;
        self.nodataView.hidden = self.historyArr.count != 0;
        self.tableView.hidden = self.historyArr.count == 0;
        return self.historyArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 104;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoCell class]) forIndexPath:indexPath];
    FileModel *model = _currentIndex==0 ? self.localArr[indexPath.row] : self.historyArr[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FileModel *model = _currentIndex==0 ? self.localArr[indexPath.row] : self.historyArr[indexPath.row];
    AudioDetailController *videoVc = [AudioDetailController new];
    videoVc.fileModel = model;
    [self.navigationController pushViewController:videoVc animated:YES];
}

#pragma mark - Private Method
- (void)refreshData {
    if (_currentIndex == 0) {
        [self.localArr removeAllObjects];
        [self.localArr addObjectsFromArray:[FileLogDao allFileLogs]];
    }else {
        [self.historyArr removeAllObjects];
        [self.historyArr addObjectsFromArray:[FileLogDao allHistoryLogs]];
    }
    [self.tableView reloadData];
}

#pragma mark - Lazy Method

- (NSMutableArray *)localArr {
    if (!_localArr) {
        _localArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _localArr;
}

- (NSMutableArray *)historyArr {
    if (!_historyArr) {
        _historyArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _historyArr;
}

@end
