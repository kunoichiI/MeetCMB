//
//  MemberViewCell.h
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImage/UIImageView+WebCache.h"

@interface MemberViewCell : UICollectionViewCell
@property(nonatomic) UILabel *title;
@property(nonatomic) UILabel *name;
@property(nonatomic) UIImageView *photo;

-(id)initWithFrame:(CGRect)frame;
@end
