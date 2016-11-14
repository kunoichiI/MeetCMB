//
//  MembersViewController.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBMembersViewController.h"
#import "CMBMemberCell.h"
#import "CMBMemberDetailViewController.h"

static NSString * const kPhotoCellIdentifier = @"PhotoCell";

@interface CMBMembersViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UIImageView *imageViewTitle;
@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic) NSArray *profiles;
@property (nonatomic) NSMutableArray *searchResults;

@end

@implementation CMBMembersViewController

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.imageViewTitle;
    [self.view addSubview:self.collectionView];
    
    [self loadProfiles];
}

#pragma mark - Load Profiles

- (void)loadProfiles {
    SetWeakSelf
    [CMBService retrieveTeamProfilesWithCompletionBlock:^(BOOL success, NSArray *profiles) {
        if (success) {
            weakSelf.profiles = profiles;
            [weakSelf.collectionView reloadData];
        }
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.profiles count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMBMemberProfile *profile = [self.profiles objectAtIndex:indexPath.item];
    CMBMemberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellIdentifier forIndexPath:indexPath];
    [cell updateCellWithProfile:profile];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    [[CMBAudioHelper sharedHelper] playBlingSound];
    
    if (collectionView == self.collectionView) {
        CMBMemberDetailViewController *detailViewController = [[CMBMemberDetailViewController alloc] init];
        CMBMemberProfile *profile = [self.profiles objectAtIndex:indexPath.item];
        detailViewController.profile = profile;
        SetEmptyBackBarButtonItem
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

#pragma mark - Lazy Loading

- (UIImageView *)imageViewTitle {
    if (!_imageViewTitle) {
        _imageViewTitle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 98, 32)];
        _imageViewTitle.image = [UIImage imageNamed:@"banner-cmb"];
        _imageViewTitle.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageViewTitle;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(kMemberViewCellWidth, kMemberViewCellHeight);
        layout.sectionInset = UIEdgeInsetsMake(10.0, 20.0, 10.0, 20.0);
        layout.minimumLineSpacing = 0.0;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CMBMemberCell class] forCellWithReuseIdentifier:kPhotoCellIdentifier];
    }
    return _collectionView;
}

@end
