//
//  MemberViewCell.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "MemberViewCell.h"

@implementation MemberViewCell

-(void)setTitle:(UILabel *)title {
    _title = title;
    
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(26, 125, 90, 21)];
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(11, 156, 121, 21)];
        self.name.textColor = [UIColor blackColor];
        self.title.textColor = [UIColor blackColor];
        
        [self.viewForFirstBaselineLayout addSubview:self.title];
        [self.viewForLastBaselineLayout addSubview:self.name];
        
        self.viewForFirstBaselineLayout.layer.masksToBounds = YES;
    }
    return self;
}

@end
