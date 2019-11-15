//
//  UIViewController+AOP.m
//  BookStore
//
//  Created by 龙格 on 2019/7/13.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "UIViewController+AOP.h"
#import <objc/runtime.h>

@implementation UIViewController (AOP)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([self class], @selector(viewDidLoad)),
                                   class_getInstanceMethod([self class], @selector(mavericks_viewDidLoad)));
}

- (void)mavericks_viewDidLoad {
    [self mavericks_viewDidLoad];
    if (self.navigationController.viewControllers.count > 1 && !self.navigationItem.leftBarButtonItem && self.navigationItem.leftBarButtonItems.count == 0) {
        UIImage *image = [[UIImage imageNamed:@"ic_back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(popBackWithAnimation)];
    }
}

- (void)popBackWithAnimation {
    [self popBackWithAnimated:YES];
}

#pragma mark - Interface Method
- (void)popBack {
    [self popBackWithAnimated:YES];
}

- (void)popBackWithAnimated:(BOOL)animated {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:animated];
    }else {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

@end
