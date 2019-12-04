//
//  NormalView.m
//  XTLocalPlayer
//
//  Created by upon on 2019/12/4.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "NormalView.h"

@interface NormalView ()

@property (nonatomic, assign) IBOutlet UILabel *labelDetail;

@end

@implementation NormalView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setTitle:(NSString *)title {
    _title = title;
    self.labelDetail.text = title;
}

@end
