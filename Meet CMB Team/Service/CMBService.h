//
//  CMBService.h
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/14/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMBService : NSObject

+ (void)retrieveTeamProfilesWithCompletionBlock:(void (^)(BOOL success, NSArray *profiles))completionBlock;

@end
