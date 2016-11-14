//
//  CMBMemberCell.h
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kImageViewPhotoLength ((ScreenWidth - 20 * 3) / 2.0 - kGreatPadding * 2)
#define kLabelTitleHeight 20
#define kLabelNameHeight 20

#define kMemberViewCellWidth (ScreenWidth - 20 * 3) / 2.0
#define kMemberViewCellHeight kGreatPadding * 3 + kImageViewPhotoLength + kLabelTitleHeight + kLabelNameHeight

@interface CMBMemberCell : UICollectionViewCell

@property(nonatomic) UILabel *labelTitle;
@property(nonatomic) UILabel *labelName;
@property(nonatomic) UIImageView *imageViewPhoto;

- (void)updateCellWithProfile:(CMBMemberProfile *)profile;

@end
