//
//  CMBService.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/14/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBService.h"

@implementation CMBService

+ (void)retrieveTeamProfilesWithCompletionBlock:(void (^)(BOOL success, NSArray *profiles))completionBlock {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"team" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error) {
        completionBlock(NO, nil);
        return;
    }
    
    completionBlock(YES, [CMBService parseProfilesJson:json]);
}

+ (NSArray *)parseProfilesJson:(NSArray *)profilesJson {
    NSMutableArray *profiles = [[NSMutableArray alloc] init];
    
    for (NSDictionary *profileInfo in profilesJson) {
        CMBMemberProfile *profile = [[CMBMemberProfile alloc] initWithInfo:profileInfo];
        [profiles addObject:profile];
    }
    
    return profiles;
}

@end
