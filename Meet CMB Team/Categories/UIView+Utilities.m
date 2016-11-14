//
//  UIView+Utilities.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/14/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "UIView+Utilities.h"

@implementation UIView (Utilities)

- (void)becomeRound {
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2.0;
    self.layer.masksToBounds = YES;
}

@end
