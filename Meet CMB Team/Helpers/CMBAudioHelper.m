//
//  CMBAudioHelper.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/14/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBAudioHelper.h"

@implementation CMBAudioHelper

+ (void)playBlingSound {
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *path = [NSString stringWithFormat:@"%@/sound.mp3", resourcePath];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [player play];
}

@end
