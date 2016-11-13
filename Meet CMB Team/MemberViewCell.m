//
//  MemberViewCell.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "MemberViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CMBMemberProfile.h"


@implementation MemberViewCell


-(id)initWithFrame:(CGRect) frame {
        self = [super initWithFrame:frame];
    
        if(self) {
            self.title = [[UILabel alloc]initWithFrame:CGRectMake(53, 150, 100, 24)];
            self.name = [[UILabel alloc]initWithFrame:CGRectMake(13, 180, 180, 21)];
            self.photo.frame = CGRectMake(28, 28, 150, 150);
            self.backgroundColor=[UIColor colorWithRed:145/255.0 green:146/255.0 blue:138/255.0 alpha:1.0];
        
        
            // configure UILabels and UIImageViews
            self.title.lineBreakMode = NSLineBreakByWordWrapping;
            self.title.numberOfLines = 0;
            self.title.backgroundColor = [UIColor blackColor]; // for debugging
            self.photo.backgroundColor = [UIColor blueColor];
            self.name.backgroundColor = [UIColor redColor];
        
            self.photo.contentMode = UIViewContentModeScaleAspectFit;
            self.name.textColor = [UIColor whiteColor];
            self.title.textColor = [UIColor whiteColor];
            [self.name setFont:[UIFont fontWithName:@"Symbol" size:14.0f]];
            [self.title setFont:[UIFont fontWithName:@"Symbol" size:12.0f]];
            self.title.textAlignment = NSTextAlignmentCenter;
            self.name.textAlignment = NSTextAlignmentCenter;
            self.title.backgroundColor = [UIColor clearColor];
            self.name.backgroundColor = [UIColor clearColor];
            self.photo.layer.borderWidth = 1;
            self.photo.layer.borderColor = [[UIColor clearColor] CGColor];
            self.title.layer.shadowColor = [[UIColor blackColor] CGColor];
            self.photo.clipsToBounds = YES;
            self.photo.layer.cornerRadius = 20;
            
            self.title.layer.shadowRadius = 1.0f;
            self.title.layer.shadowOpacity = 0.5;
            self.title.layer.shadowOffset = CGSizeMake(0,2);
            
            [self.viewForFirstBaselineLayout addSubview:self.photo];
            [self.viewForFirstBaselineLayout addSubview:self.title];
            [self.viewForFirstBaselineLayout addSubview:self.name];
        
            self.viewForFirstBaselineLayout.layer.masksToBounds = YES;
        }
        return self;
}

@end
