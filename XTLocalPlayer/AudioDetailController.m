//
//  AudioDetailController.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/14.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "AudioDetailController.h"

#import "ZFCustomControlView1.h"
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFUtilities.h>
#import "UIImageView+ZFCache.h"

@interface AudioDetailController ()
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFCustomControlView1 *controlView;
@end

static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";

@implementation AudioDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.fileModel.name;

    [self.view addSubview:self.containerView];

    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
    [self.player seekToTime:self.fileModel.progress completionHandler:nil];
    
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
    };
    
    /// 正在播放
    self.player.playerPlayTimeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSTimeInterval currentTime, NSTimeInterval duration) {
        @strongify(self)
        [FileLogDao updateProgress:currentTime withPath:self.fileModel.path];
        
        if (currentTime == duration) {
            // 保存播放记录
            self.fileModel.playCount += 1;
            [FileLogDao updatePlayCountWithModel:self.fileModel];
        }
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player.currentPlayerManager replay];
        [self.player playTheNext];
        if (!self.player.isLastAssetURL) {
            [self.controlView showTitle:self.fileModel.name coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
        } else {
            [self.player stop];
        }
    };
    
    playerManager.assetURL = [NSURL fileURLWithPath:[File_PATH stringByAppendingString:self.fileModel.path]];
    CLog(@"====>: %@", playerManager.assetURL);
    [self.controlView showTitle:self.fileModel.name coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
    
    CLog(@"_____:%@", self.fileModel);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat h = kScreen_W*9/16;
    [self.containerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.containerView autoSetDimension:ALDimensionHeight toSize:h];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Lazy Method
- (ZFCustomControlView1 *)controlView {
    if (!_controlView) {
        _controlView = [ZFCustomControlView1 new];
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        [_containerView setImageWithURLString:kVideoCover placeholder:[ZFUtilities imageWithColor:UIColor.randomColor size:CGSizeMake(1, 1)]];
    }
    return _containerView;
}

@end
