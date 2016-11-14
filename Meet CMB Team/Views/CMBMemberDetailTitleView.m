//
//  CMBMemberDetailTitleView.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/14/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBMemberDetailTitleView.h"

@interface CMBMemberDetailTitleView()

@property (nonatomic) UILabel *labelTitle;
@property (nonatomic) UILabel *labelName;

@end

@implementation CMBMemberDetailTitleView

#pragma mark - Initialization

- (instancetype)initWithProfile:(CMBMemberProfile *)profile {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 200, 40);
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.labelTitle];
        [self addSubview:self.labelName];
        
        self.labelTitle.text = profile.profileTitle;
        self.labelName.text = [profile profileFullName];
    }
    return self;
}

#pragma mark - Lazy Loading

- (UILabel *)labelTitle {
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 20)];
        _labelTitle.font = [UIFont labelTitleFont];
        _labelTitle.textColor = [UIColor lightGrayColor];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labelTitle;
}

- (UILabel *)labelName {
    if (!_labelName) {
        _labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 18, CGRectGetWidth(self.frame), 20)];
        _labelName.font = [UIFont labelNameFont];
        _labelName.textColor = [UIColor themeColor];
        _labelName.textAlignment = NSTextAlignmentCenter;
    }
    return _labelName;
}

@end
