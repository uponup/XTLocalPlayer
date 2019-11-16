//
//  AppDelegate+Launch.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/16.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "AppDelegate+Launch.h"
#import "LaunchView.h"

@implementation AppDelegate (Launch)

- (void)showLaunchImage {
    LaunchView *launchView = [[LaunchView alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:launchView];
    [launchView autoPinEdgesToSuperviewEdges];
    [launchView animate];
}

@end
