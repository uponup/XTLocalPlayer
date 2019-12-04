//
//  NSString+Extend.h
//  XTLocalPlayer
//
//  Created by upon on 2019/12/4.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extend)
- (NSString *)removeWhiteSpace;
- (NSString *)removeWhiteSpaceAndLineBreak;
@end

NS_ASSUME_NONNULL_END
