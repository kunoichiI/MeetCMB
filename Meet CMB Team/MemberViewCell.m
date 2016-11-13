//
//  MemberViewCell.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "MemberViewCell.h"

@implementation MemberViewCell


-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(13, 154, 180, 21)];
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(13, 175, 180, 21)];
        self.background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder"]];
        
        self.background.frame = CGRectMake(28, 28, 150, 150);
        self.background.contentMode = UIViewContentModeScaleAspectFit;
        self.name.textColor = [UIColor whiteColor];
        self.title.textColor = [UIColor whiteColor];
        [self.name setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
        [self.title setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.name.textAlignment = NSTextAlignmentCenter;
        self.title.backgroundColor = [UIColor clearColor];
        self.name.backgroundColor = [UIColor clearColor];
        self.title.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.title.layer.shadowRadius = 1.0f;
        self.title.layer.shadowOpacity = 0.5;
        self.title.layer.shadowOffset = CGSizeMake(0,2);
        
        [self.viewForFirstBaselineLayout addSubview:self.background];
        [self.viewForFirstBaselineLayout addSubview:self.title];
        [self.viewForFirstBaselineLayout addSubview:self.name];
        
        self.viewForFirstBaselineLayout.layer.masksToBounds = YES;
    }
    return self;
}

@end
