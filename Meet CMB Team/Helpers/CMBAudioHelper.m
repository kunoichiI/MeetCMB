//
//  CMBAudioHelper.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/14/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBAudioHelper.h"

@interface CMBAudioHelper()

@property (nonatomic) AVAudioPlayer *player;

@end

@implementation CMBAudioHelper

+ (instancetype)sharedHelper {
    static dispatch_once_t token;
    static CMBAudioHelper *sharedHelper;
    dispatch_once(&token, ^{
        sharedHelper = [[CMBAudioHelper alloc] init];
    });
    return sharedHelper;
}

- (void)playBlingSound {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"wav"];
    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
    [self.player play];
}

@end
