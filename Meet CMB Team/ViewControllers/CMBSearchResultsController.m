//
//  CMBSearchResultsController.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/13/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBSearchResultsController.h"
#import "CMBMemberCell.h"
#import "CMBMemberProfile.h"

static NSString * const photoCellIdentifier = @"ProfileCell";

@interface CMBSearchResultsController ()

@end

@implementation CMBSearchResultsController

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CMBMemberCell class] forCellWithReuseIdentifier:photoCellIdentifier];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.filteredProfiles count];
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMBMemberProfile *profile = [self.filteredProfiles objectAtIndex:indexPath.item];
    CMBMemberCell *cell = (CMBMemberCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:photoCellIdentifier forIndexPath:indexPath];
    [cell updateCellWithProfile:profile];
    return cell;
}



@end
