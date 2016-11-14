//
//  MembersViewController.m
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import "CMBMembersViewController.h"
#import "CMBMemberViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
#import "CMBSearchResultsController.h"
#import "CMBMemberProfile.h"
#import "CMBDetailViewController.h"
static NSString * const photoCellIdentifier = @"ProfileCell";
@interface CMBMembersViewController () <UICollectionViewDelegate>
@property(nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) CMBSearchResultsController *resultsCollectionController;


@end

@implementation CMBMembersViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // navigation picture(CMB logo)
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 32)];
    iv.image = [UIImage imageNamed:@"CMB"];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = iv;
    
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
    
    // Set FlowLayout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    [self.collectionView registerClass:[CMBMemberViewCell class] forCellWithReuseIdentifier:photoCellIdentifier];
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView addSubview:self.searchController.searchBar];
    
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
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


#pragma mark - <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - <MemoryWarningInfo>

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.profiles count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMBMemberViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    [cell updateCellWithProfile:self.profiles atIndexPath:indexPath];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // play sound whenever you tap a cell
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *path = [NSString stringWithFormat:@"%@/sound.mp3", resourcePath];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    self.player.numberOfLoops = 0;
    self.player.delegate = self;
    [self.player play];
    
    // we are the collection view delegate for both our main collection view and filtered collection,
    // so we can push from the current navigation controller(resultsCollectionController's parent view controller is not this UINavigationController)
    NSDictionary *selectedProfile = (collectionView == self.collectionView)? self.profiles[indexPath.row] :self.resultsCollectionController.filteredProfiles[indexPath.row];
    CMBDetailViewController *detailViewController = [[CMBDetailViewController alloc]init];
    detailViewController.profile = [[CMBMemberProfile alloc] initWithTitle:selectedProfile[@"title"] firstName:selectedProfile[@"firstName"] lastName:selectedProfile[@"lastName"] avatar:selectedProfile[@"avatar"] bio:selectedProfile[@"bio"]];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"%d",flag);
}


#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(206.0, 206.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(44.0, 0, 0, 0);
}

#pragma mark - <UISearchResultsUpdating>

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // set searchString equal to what's typed into the searchbar
    NSString *searchString = searchController.searchBar.text;
    [self updateFilteredContentForMemberProfile:searchString];
    
    
    CMBSearchResultsController *vc = (CMBSearchResultsController *)self.searchController.searchResultsController;
    
    vc.filteredProfiles = [self.searchResults copy];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    NSLog(@"%@", self.searchResults);
    [vc.collectionView reloadData];
    [self presentViewController:nav animated:YES completion:nil];
    
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

@end
