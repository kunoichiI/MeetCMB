//
//  MemberViewCell.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBMemberViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CMBMemberProfile.h"


@implementation CMBMemberViewCell


-(id)initWithFrame:(CGRect) frame {
        self = [super initWithFrame:frame];
    
        if(self) {
            self.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
        }
        return self;
}

@end
