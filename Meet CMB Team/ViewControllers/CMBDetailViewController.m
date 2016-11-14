//
//  CMBDetailViewController.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBDetailViewController.h"

@interface CMBDetailViewController ()

@property (nonatomic, strong) UILabel *labelMyBio;
@property (nonatomic, strong) UILabel *labelBio;
@property (nonatomic, strong) UIImageView *imageViewPhoto;

@end

@implementation CMBDetailViewController

#pragma mark - View Controller Lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    self.title = [self.profile profileFullName];
    
    self.labelBio = [[UILabel alloc] initWithFrame:CGRectMake(44, 50, 100, 75)];
    self.labelBio.backgroundColor = [UIColor blackColor];
    self.labelBio.text = @"My Story";
    
    self.labelBio.font = [UIFont openSansBoldFontOfSize:14.0f];
    self.labelMyBio = [[UILabel alloc] initWithFrame:CGRectMake(0, 135, 200, 135)];
   
    self.labelMyBio.backgroundColor = [UIColor redColor];
    self.labelMyBio.text = self.profile.profileBio;
    self.labelMyBio.font = [UIFont fontWithName:@"Arial" size:10];
    [self.labelMyBio sizeToFit];
    self.labelMyBio.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelMyBio.numberOfLines = 0;
    
    [self.view addSubview:self.labelBio];
    [self.view addSubview:self.labelMyBio];
}

@end
