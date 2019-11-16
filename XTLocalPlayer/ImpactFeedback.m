//
//  ImpactFeedback.m
//  XTLocalPlayer
//
//  Created by 龙格 on 2019/11/16.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "ImpactFeedback.h"


@implementation ImpactFeedback

+ (void)feedbackGeneratorStyle:(UIImpactFeedbackStyle)style {
    if (@available(iOS 10.0, *)) {
        if (style > 2) {
            UISelectionFeedbackGenerator *feedbackSelection = [[UISelectionFeedbackGenerator alloc] init];
            [feedbackSelection selectionChanged];
        }else {
            UIImpactFeedbackGenerator *feedbackGenerate = [[UIImpactFeedbackGenerator alloc] initWithStyle:style];
            [feedbackGenerate impactOccurred];
        }
    };
}

@end
