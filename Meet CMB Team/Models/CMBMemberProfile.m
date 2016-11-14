//
//  CMBMemberProfile.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/13/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBMemberProfile.h"

@implementation CMBMemberProfile

#pragma mark - Initialization

- (instancetype)initWithInfo:(NSDictionary *)info {
    self = [super init];
    
    if (self) {
        self.profileTitle = info[@"title"];
        self.profileFirstName = info[@"firstName"];
        self.profileLastName = info[@"lastName"];
        self.profileAvatarUrl = info[@"avatar"];
        self.profileBio = info[@"bio"];
    }
    
    return self;
}

#pragma mark - Helpers

- (NSString *)profileFullName {
    return [NSString stringWithFormat:@"%@ %@", self.profileFirstName, self.profileLastName];
}

@end
