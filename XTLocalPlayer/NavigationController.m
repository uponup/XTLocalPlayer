//
//  NavigationController.m
//  BookStore
//
//  Created by 龙格 on 2019/7/13.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.navigationBar.translucent = NO;
        self.navigationBar.shadowImage = [UIImage new];
        [self findLineViewFromView:self.navigationBar].hidden = YES;
   
        self.navigationBar.barTintColor = GlobalThemeColor;
        self.navigationBar.tintColor = GlobalThemeColor;
        [self.navigationBar setTitleTextAttributes:@{
                                                     NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:22],
                                                     NSForegroundColorAttributeName: UIColor.whiteColor
                                                     }];
        self.interactivePopGestureRecognizer.delegate = self;
    }
    return self;
}

- (UIView *)findLineViewFromView:(UIView *)view {
    if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1.0) {
        return view;
    } else {
        for (UIView *subView in view.subviews) {
            return [self findLineViewFromView:subView];
        }
        return nil;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    return [super pushViewController:viewController animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}
@end
