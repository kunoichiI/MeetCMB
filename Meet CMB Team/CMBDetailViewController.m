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
@property (nonatomic, strong) UIImageView *imageViewPhoto;

@end

@implementation CMBDetailViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@%@%@", self.profile.firstName, @"  ", self.profile.lastName];
    
    
    //NSLog(@"%@", self.profile.bio);
    self.labelBio = [[UILabel alloc] initWithFrame:CGRectMake(44, 50, 100, 75)];
    self.labelBio.backgroundColor = [UIColor blackColor];
    self.labelBio.text = @"My Story";
    
    self.labelBio.font = [UIFont openSansBoldFontOfSize:14.0f];
    self.labelMyBio = [[UILabel alloc] initWithFrame:CGRectMake(0, 135, 200, 135)];
   
    self.labelMyBio.backgroundColor = [UIColor redColor];
    self.labelMyBio.text = self.profile.bio;
    self.labelMyBio.font = [UIFont fontWithName:@"Arial" size:10];
    [self.labelMyBio sizeToFit];
    self.labelMyBio.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelMyBio.numberOfLines = 0;
    
    [self.view addSubview:self.labelBio];
    [self.view addSubview:self.labelMyBio];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIStateRestoration

NSString *const ViewControllerProductKey = @"ViewControllerProductKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the product
    [coder encodeObject:self.profile forKey:ViewControllerProductKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the product
    self.profile = [coder decodeObjectForKey:ViewControllerProductKey];
}

@end
