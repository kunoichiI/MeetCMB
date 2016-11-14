//
//  MemberViewCell.h
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImage/UIImageView+WebCache.h"


@interface CMBMemberViewCell : UICollectionViewCell
@property(nonatomic) UILabel *labelTitle;
@property(nonatomic) UILabel *labelName;
@property(nonatomic) UIImageView *imageViewPhoto;

-(id)initWithCoder:(NSCoder *)aDecoder;
- (void) updateCellWithProfile: (NSArray *) profiles atIndexPath:(NSIndexPath *) indexPath;

@end
