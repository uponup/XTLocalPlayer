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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTableBottom;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (nonatomic, strong) NSMutableArray *localArr;
@property (nonatomic, strong) NSMutableArray *historyArr;
@property (nonatomic, strong) NSMutableArray *dataArr;

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

- (IBAction)selectAllAction:(UIButton *)sender {
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:NSLocalizedString(@"全选", nil)]) {
        [self.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CLog(@"===>:%@", @(idx));
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }];
        [sender setTitle:NSLocalizedString(@"取消全选", nil) forState:UIControlStateNormal];
    }else {
        [self.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        }];
        [sender setTitle:NSLocalizedString(@"全选", nil) forState:UIControlStateNormal];
    }
}

- (IBAction)deleteAllAction:(id)sender {
    NSMutableArray *selectedArr = [NSMutableArray arrayWithCapacity:0];
    [[self.tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FileModel *model = self.dataArr[obj.row];
        [selectedArr addObject:model];
    }];
    
    [Hud showSuccessWithStatus:NSLocalizedString(@"删除成功!", nil)];
    [self refreshData];
}

- (IBAction)uploadButtonAction:(id)sender {
    TransportViewController *transportVc = [TransportViewController new];
    [self.navigationController pushViewController:transportVc animated:YES];
}

- (IBAction)deleteButtonAction:(id)sender {
    self.tableView.editing = !self.tableView.editing;
    [UIView animateWithDuration:0.27 animations:^{
        self.layoutTableBottom.constant = self.tableView.editing ? 0 : 46;
        self.stackView.hidden = !self.tableView.editing;
        [self.view layoutIfNeeded];
    }];
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
    FileModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isEditing) {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        return;
    }
    
    FileModel *model = self.dataArr[indexPath.row];
    AudioDetailController *videoVc = [AudioDetailController new];
    videoVc.fileModel = model;
    [self.navigationController pushViewController:videoVc animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

#pragma mark - Private Method
- (void)refreshData {
    [self.dataArr removeAllObjects];
    if (_currentIndex == 0) {
        [self.dataArr addObjectsFromArray:self.localArr];
    }else {
        [self.dataArr addObjectsFromArray:self.historyArr];
    }
    [self.tableView reloadData];
}

#pragma mark - Lazy Method

- (NSMutableArray *)localArr {
    if (!_localArr) {
        _localArr = [NSMutableArray arrayWithArray:[FileLogDao allFileLogs]];
;
    }
    return _localArr;
}

- (NSMutableArray *)historyArr {
    if (!_historyArr) {
        _historyArr = [NSMutableArray arrayWithArray:[FileLogDao allHistoryLogs]];
    }
    return _historyArr;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

@end
