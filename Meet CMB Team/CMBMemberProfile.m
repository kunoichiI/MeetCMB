//
//  CMBMemberProfile.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/13/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBMemberProfile.h"

@implementation CMBMemberProfile

- (id) initWithTitle:(NSString *) title firstName:(NSString *)firstName lastName:(NSString *)lastName avatar:(NSString *)avatar bio:(NSString *) bio {
    self = [super init];
    
    if (self) {
        self.title = title;
        self.firstName = firstName;
        self.lastName = lastName;
        self.avatar = avatar;
        self.bio = bio;
    }
    return self;
}

@end
