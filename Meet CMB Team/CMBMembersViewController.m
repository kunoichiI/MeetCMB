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
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) CMBSearchResultsController *resultsCollectionController;

// for state restoration
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;
@end

@implementation CMBMembersViewController



- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.searchController.searchBar.placeholder = @"Search people here";
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

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // restore the searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
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
    //NSLog(@"%@", [detailViewController.profile class]);
    
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

#pragma mark - <<#pragma mark - UISearchResultsUpdating>

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // set searchString equal to what's typed into the searchbar
    NSString *searchString = searchController.searchBar.text;
    NSMutableArray *searchResults = [self.profiles mutableCopy];
    
    if (searchString != nil) {
        searchResults = [[NSMutableArray alloc] init];
        for (NSDictionary *profile in self.profiles) {
            if ([profile[@"firstName"] containsString:searchString] || [profile[@"lastName"] containsString:searchString] || [profile[@"title"] containsString:searchString]) {
                [searchResults addObject:profile];
            }
        }
    }
    
        // hand over the filtered results to out search results collectionview
    CMBSearchResultsController *collectionviewController = (CMBSearchResultsController *)self.searchController.searchResultsController;
    collectionviewController.filteredProfiles = searchResults;
    NSLog(@"%@", searchResults);
    [collectionviewController.collectionView reloadData];
    
}

#pragma mark - <UIStateRestoration>

// restore several items for state restoration:
// 1) Search Controller's active state,
// 2) Search text,
// 3) first responder

NSString *const ViewControllerTitleKey = @"VIewControllerTitleKey";
NSString *const SearchControllerIsActiveKey = @"SearchControllerIsActiveKey";
NSString *const SearchBarTextKey = @"SearchBarTextKey";
NSString *const SearchBarIsFirstResponderKey = @"SearchBarIsFirstREsponderKey";

- (void) encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the view state so it can be restored later
    // encode the title
    [coder encodeObject:self.title forKey:ViewControllerTitleKey];
    
    UISearchController *searchController = self.searchController;
    
    // encode the search controller's active state
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:SearchControllerIsActiveKey];
    
    // encode the first responder status
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:SearchBarIsFirstResponderKey];
    }
    
    // encode the searchBar text
    [coder encodeObject:searchController.searchBar.text forKey:SearchBarTextKey];
}

- (void) decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the title
    self.title = [coder decodeObjectForKey:ViewControllerTitleKey];
    
    // restore the active state
    // we can't make the searchController active here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    _searchControllerWasActive = [coder decodeBoolForKey:SearchControllerIsActiveKey];
    
    // restore the first responder status:
    // we can't make the searchController first responder here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:SearchBarIsFirstResponderKey];
    
    // restore the text in the search field
    self.searchController.searchBar.text =[coder decodeObjectForKey:SearchBarTextKey];
}
@end
