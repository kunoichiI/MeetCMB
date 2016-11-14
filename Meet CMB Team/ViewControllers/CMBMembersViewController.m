//
//  MembersViewController.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBMembersViewController.h"
#import "CMBMemberCell.h"
#import "CMBSearchResultsController.h"
#import "CMBDetailViewController.h"

static NSString * const kPhotoCellIdentifier = @"PhotoCell";

@interface CMBMembersViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate>

@property (nonatomic) UIImageView *imageViewTitle;
@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic) NSArray *profiles;
@property (nonatomic) NSMutableArray *searchResults;

@property (nonatomic) UISearchController *searchController;
@property (nonatomic) CMBSearchResultsController *resultsCollectionController;

@end

@implementation CMBMembersViewController

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.imageViewTitle;
    
    _resultsCollectionController = [[CMBSearchResultsController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsCollectionController];
    [self.searchController.searchBar sizeToFit];
    
    // set the delegate for our filtered collection view
    self.resultsCollectionController.collectionView.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.searchController.searchBar.placeholder = @"Search us here";
    self.searchController.searchBar.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = YES;
    self.definesPresentationContext = YES; // know where UISearchController to be displayed
    
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:self.searchController.searchBar];
    
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
    
    [CMBAudioHelper playBlingSound];
    
    if (collectionView == self.collectionView) {
        CMBDetailViewController *detailViewController = [[CMBDetailViewController alloc] init];
        CMBMemberProfile *profile = [self.profiles objectAtIndex:indexPath.item];
        detailViewController.profile = profile;
        SetEmptyBackBarButtonItem
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // set searchString equal to what's typed into the searchbar
    NSString *searchString = searchController.searchBar.text;
    [self updateFilteredContentForMemberProfile:searchString];
    
    
    CMBSearchResultsController *vc = (CMBSearchResultsController *)self.searchController.searchResultsController;
    
    vc.filteredProfiles = [self.searchResults copy];
    // UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    NSLog(@"%@", self.searchResults);
    [vc.collectionView reloadData];
    //[self presentViewController:nav animated:YES completion:nil];
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}

- (void)updateFilteredContentForMemberProfile:(NSString *)searchString {
    NSMutableArray *searchResults = [self.profiles mutableCopy];
    
    if (searchString != nil) {
        searchResults = [[NSMutableArray alloc] init];
        for (NSDictionary *profile in self.profiles) {
            if ([profile[@"firstName"] localizedCaseInsensitiveContainsString:searchString] || [profile[@"lastName"] localizedCaseInsensitiveContainsString:searchString] || [profile[@"title"] localizedCaseInsensitiveContainsString:searchString]) {
                [searchResults addObject:profile];
            }
            self.searchResults = searchResults;
        }
    }
}

#pragma mark - UISearchControllerDelegate

// Called after the search controller's search bar has agreed to begin editing or when
// 'active' is set to YES.
// If you choose not to present the controller yourself or do not implement this method,
// a default presentation is performed on your behalf.
//
// Implement this method if the default presentation is not adequate for your purposes.
//
- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
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
        layout.sectionInset = UIEdgeInsetsMake(54.0, 20.0, 20.0, 20.0);
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
