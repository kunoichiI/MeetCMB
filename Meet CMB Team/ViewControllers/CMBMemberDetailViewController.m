//
//  CMBMemberDetailViewController.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBMemberDetailViewController.h"
#import "CMBMemberDetailTitleView.h"

@interface CMBMemberDetailViewController ()

@property (nonatomic) UIImageView *imageViewPhoto;
@property (nonatomic) UITextView *textViewBio;

@property (nonatomic) CMBMemberDetailTitleView *titleViewMemberDetail;

@end

@implementation CMBMemberDetailViewController

#pragma mark - View Controller Lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.titleViewMemberDetail;
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.imageViewPhoto];
    [self.view addSubview:self.textViewBio];
}

#pragma mark - Lazy Loading

- (CMBMemberDetailTitleView *)titleViewMemberDetail {
    if (!_titleViewMemberDetail) {
        _titleViewMemberDetail = [[CMBMemberDetailTitleView alloc] initWithProfile:self.profile];
    }
    return _titleViewMemberDetail;
}

- (UIImageView *)imageViewPhoto {
    if (!_imageViewPhoto) {
        _imageViewPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, kImageViewPhotoHeight)];
        _imageViewPhoto.backgroundColor = [UIColor blueColor];
        _imageViewPhoto.contentMode = UIViewContentModeScaleAspectFill;
        _imageViewPhoto.clipsToBounds = YES;
        [_imageViewPhoto sd_setImageWithURL:[NSURL URLWithString:self.profile.profileAvatarUrl]];
    }
    return _imageViewPhoto;
}

- (UITextView *)textViewBio {
    if (!_textViewBio) {
        _textViewBio = [[UITextView alloc] initWithFrame:CGRectMake(kGreatPadding, CGRectGetMaxY(self.imageViewPhoto.frame), ScreenWidth - kGreatPadding * 2, ScreenHeight - kStatusAndNavBarHeight - kImageViewPhotoHeight)];
        _textViewBio.contentInset = UIEdgeInsetsMake(kGreatPadding / 2.0, 0, kGreatPadding / 2.0, 0);
        _textViewBio.alwaysBounceVertical = YES;
        _textViewBio.showsVerticalScrollIndicator = NO;
        _textViewBio.font = [UIFont textViewBioFont];
        _textViewBio.text = self.profile.profileBio;
    }
    return _textViewBio;
}

@end
