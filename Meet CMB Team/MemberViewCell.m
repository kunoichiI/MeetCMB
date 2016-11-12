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
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(42, 154, 122, 21)];
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(42, 175, 122, 21)];
        self.name.textColor = [UIColor whiteColor];
        self.title.textColor = [UIColor whiteColor];
        [self.name setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
        [self.title setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.name.textAlignment = NSTextAlignmentCenter;
        
        [self.viewForFirstBaselineLayout addSubview:self.title];
        [self.viewForFirstBaselineLayout addSubview:self.name];
        
        self.viewForFirstBaselineLayout.layer.masksToBounds = YES;
    }
    return self;
}

@end
