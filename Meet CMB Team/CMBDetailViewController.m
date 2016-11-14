//
//  DetailViewController.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBDetailViewController.h"
#import <OpenSans/UIFont+OpenSans.h>

@interface CMBDetailViewController ()

@property (nonatomic, strong) UILabel *labelMyBio;
@property (nonatomic, strong) UILabel *labelBio;

@end

@implementation CMBDetailViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Hello";
    
    
    NSLog(@"%@", self.profile.bio);
    self.labelBio = [[UILabel alloc] initWithFrame:CGRectMake(44, 50, 100, 75)];
    self.labelBio.backgroundColor = [UIColor blackColor];
    self.labelBio.text = @"My Story";
    
    self.labelBio.font = [UIFont openSansBoldFontOfSize:14.0f];
    self.labelMyBio = [[UILabel alloc] initWithFrame:CGRectMake(0, 135, 200, 135)];
   
    self.labelMyBio.backgroundColor = [UIColor redColor];
    self.labelMyBio.text = self.profile.bio;
    self.labelMyBio.font = [UIFont fontWithName:@"Arial" size:10];
    [self.labelMyBio sizeToFit];
    self.labelMyBio.lineBreakMode = UILineBreakModeWordWrap;
    self.labelMyBio.numberOfLines = 0;
    
    [self.view addSubview:self.labelBio];
    [self.view addSubview:self.labelMyBio];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
