//
//  NSString+Extend.m
//  XTLocalPlayer
//
//  Created by upon on 2019/12/4.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)

- (NSString *)removeWhiteSpace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)removeWhiteSpaceAndLineBreak {
    //    NSString *temp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //    return text;
    NSString *temp = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}


@end
