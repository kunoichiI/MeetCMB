//
//  CMBMemberProfile.h
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/13/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMBMemberProfile : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *avatar;
@property(nonatomic, strong) NSString *number;

- (id) initWithTitle:(NSString *) title firstName:(NSString *)firstName lastName:(NSString *)lastName avatar:(NSString *)avatar number:(NSString *) no_;

@end
