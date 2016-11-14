//
//  CMBMemberCell.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBMemberCell.h"

@implementation CMBMemberCell

#pragma mark - Update Cell

- (void)updateCellWithProfile:(CMBMemberProfile *)profile {    
    [self addSubview:self.imageViewPhoto];
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelName];
    
    self.labelTitle.text = profile.profileTitle;
    self.labelName.text = [profile profileFullName];
    [self.imageViewPhoto sd_setImageWithURL:[NSURL URLWithString:profile.profileAvatarUrl]];
}

#pragma mark - Lazy Loading

- (UIImageView *)imageViewPhoto {
    if (!_imageViewPhoto) {
        _imageViewPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(kGreatPadding, kGreatPadding, kImageViewPhotoLength, kImageViewPhotoLength)];
        _imageViewPhoto.contentMode = UIViewContentModeScaleAspectFit;
        _imageViewPhoto.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        [_imageViewPhoto becomeRound];
    }
    return _imageViewPhoto;
}

- (UILabel *)labelTitle {
    if (!_labelTitle) {
        CGFloat width = CGRectGetWidth(self.bounds) - kGreatPadding * 2;
        _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(kGreatPadding, CGRectGetMaxY(self.imageViewPhoto.frame) + kGreatPadding, width, kLabelTitleHeight)];
        _labelTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _labelTitle.numberOfLines = 0;
        _labelTitle.font = [UIFont labelTitleFont];
        _labelTitle.textColor = [UIColor lightGrayColor];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labelTitle;
}

- (UILabel *)labelName {
    if (!_labelName) {
        CGFloat width = CGRectGetWidth(self.bounds) - kGreatPadding * 2;
        _labelName = [[UILabel alloc] initWithFrame:CGRectMake(kGreatPadding, CGRectGetMaxY(self.labelTitle.frame), width, kLabelNameHeight)];
        _labelName.textColor = [UIColor themeColor];
        _labelName.font = [UIFont labelNameFont];
        _labelName.textAlignment = NSTextAlignmentCenter;
    }
    return _labelName;
}

@end
