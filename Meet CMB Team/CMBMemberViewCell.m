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
#import <OpenSans/UIFont+OpenSans.h>


@implementation CMBMemberViewCell


-(id)initWithCoder:(NSCoder *)aDecoder{
        self = [super initWithCoder:aDecoder];
    
        if(self) {
            self.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
        }
        return self;
}

- (void) updateCellWithProfile: (NSArray *) profiles atIndexPath:(NSIndexPath *) indexPath {
    NSDictionary *element = [profiles objectAtIndex:indexPath.row];
    CMBMemberProfile *profile = [[CMBMemberProfile alloc]initWithTitle:[element objectForKey:@"title"] firstName:[element objectForKey:@"firstName"] lastName:[element objectForKey:@"lastName"] avatar:[element objectForKey:@"avatar"] bio:[element objectForKey:@"bio"]];
    self.backgroundColor=[UIColor whiteColor];
    
    // configure UILabels and UIImageViews
    self.labelTitle.text = profile.title;
    self.labelName.text = [NSString stringWithFormat:@"%@%@%@", profile.firstName,@"  ", profile.lastName];
    [self.imageViewPhoto sd_setImageWithURL:[NSURL URLWithString:profile.avatar] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    [self addSubview:self.imageViewPhoto];
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelName];
    
    
    
    self.viewForFirstBaselineLayout.layer.masksToBounds = YES;
}

#pragma mark - Lazy Loading

- (UILabel *)labelTitle {
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(53, 165, 100, 24)];
        _labelTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _labelTitle.numberOfLines = 0;
        _labelTitle.font = [UIFont openSansBoldFontOfSize:11.0f];
        _labelTitle.textColor = [UIColor lightGrayColor];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labelTitle;
}

- (UILabel *)labelName {
    if (!_labelName) {
        _labelName = [[UILabel alloc]initWithFrame:CGRectMake(13, 180, 180, 21)];
        _labelName.textColor = [UIColor colorWithRed:20.0/255.0 green:101.0/255.0 blue:226.0/255.0 alpha:1.0];
        _labelName.font = [UIFont openSansBoldFontOfSize:14.0f];
        _labelName.textAlignment = NSTextAlignmentCenter;
        
    }
    return _labelName;
}

- (UIImageView *)imageViewPhoto {
    if (!_imageViewPhoto) {
        _imageViewPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 135, 135)];
        _imageViewPhoto.layer.cornerRadius = _imageViewPhoto.frame.size.width / 2;
        _imageViewPhoto.clipsToBounds = YES;
        _imageViewPhoto.contentMode = UIViewContentModeScaleAspectFit;
        _imageViewPhoto.backgroundColor = [UIColor blueColor];
    }
    return _imageViewPhoto;
}
@end
