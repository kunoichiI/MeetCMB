//
//  CMBMemberProfile.h
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/13/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMBMemberProfile : NSObject

@property(nonatomic, strong) NSString *profileTitle;
@property(nonatomic, strong) NSString *profileFirstName;
@property(nonatomic, strong) NSString *profileLastName;
@property(nonatomic, strong) NSString *profileAvatarUrl;
@property(nonatomic, strong) NSString *profileBio;

- (instancetype)initWithInfo:(NSDictionary *)info;

- (NSString *)profileFullName;

@end
