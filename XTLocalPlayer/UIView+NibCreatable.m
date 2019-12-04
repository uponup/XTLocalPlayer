//
//  UIView+NibCreatable.m
//  XTLocalPlayer
//
//  Created by upon on 2019/12/4.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "UIView+NibCreatable.h"

@implementation UIView (NibCreatable)

+ (id)createFromNib {
    NSString *nibName = NSStringFromClass([self class]);
    id view = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil].lastObject;
    if (!view) {
        view = [[[self class] alloc] init];
    }
    return view;
}

@end
