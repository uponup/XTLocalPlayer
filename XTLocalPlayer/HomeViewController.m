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

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLocalBtnCenter;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *sliderBlockView;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet UIView *nodataView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerCell:[VideoCell class]];
}

#pragma mark - Life Cycle
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self refreshData];
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
    [UIView animateWithDuration:0.27 animations:^{
        self.layoutLocalBtnCenter.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)historyButtonAction:(id)sender {
    [UIView animateWithDuration:0.27 animations:^{
        self.layoutLocalBtnCenter.constant = kScreen_W/2;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSources
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.nodataView.hidden = self.dataArr.count != 0;
    self.tableView.hidden = self.dataArr.count == 0;
    
    return self.dataArr.count;
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
    FileModel *model = self.dataArr[indexPath.row];
    AudioDetailController *videoVc = [AudioDetailController new];
    videoVc.fileModel = model;
    [self.navigationController pushViewController:videoVc animated:YES];
}

#pragma mark - Private Method
- (void)refreshData {
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:[FileLogDao allFileLogs]];
    [self.tableView reloadData];
}

#pragma mark - Lazy Method
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
}

@end
