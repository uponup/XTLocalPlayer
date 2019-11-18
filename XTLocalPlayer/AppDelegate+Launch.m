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
    
    UIViewController *launchVc = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    launchVc.view.frame = CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height);
    [self.window addSubview:launchVc.view];
    
    LaunchView *launchView = [[LaunchView alloc] init];
    launchVc.view.backgroundColor = UIColor.redColor;
    [launchVc.view addSubview:launchView];
    [launchView autoPinEdgesToSuperviewEdges];
    [launchView animate];
}

@end
