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
    
    NSDictionary *selectedProfile = (collectionView == self.collectionView)? self.profiles[indexPath.row] :self.resultsCollectionController.filteredProfiles[indexPath.row];
    CMBDetailViewController *detailViewController = [[CMBDetailViewController alloc]init];
    detailViewController.profile = [[CMBMemberProfile alloc] initWithTitle:selectedProfile[@"title"] firstName:selectedProfile[@"firstName"] lastName:selectedProfile[@"lastName"] avatar:selectedProfile[@"avatar"] bio:selectedProfile[@"bio"]];
    NSLog(@"%@", [detailViewController.profile class]);
    
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

#pragma mark - <UISearchControllerDelegate & UISearchResultsDelegate>
// Called when the search bar becomes first responder
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // set searchString equal to what's typed into the searchbar
    NSString *searchString = self.searchController.searchBar.text;
    NSMutableArray *searchResults = [self.profiles mutableCopy];
    
    // strip out all the leading and trailing spaces
    NSString *strippedString = [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // break up the search terms (separated by spaces)
    NSArray *searchItems = nil;
    if (strippedString.length > 0) {
        searchItems = [strippedString componentsSeparatedByString:@" "];
    }
    
    // build all the "AND" expressions for each value in the searchString
    NSMutableArray *andMatchPredicates= [NSMutableArray array];
    
    for (NSString *searchString in searchItems) {
        // each searchString creates an OR predicate for: name, title
        NSMutableArray *searchItemsPredicate = [NSMutableArray array];
        // Use NSExpression represent expressions in our predicates
        // NSPredicate is made up of samaller, atomic parts: two NSExpressions( a left-hand value and a right-hand value)
        
        // name field matching
        NSExpression *lhs = [NSExpression expressionForKeyPath:@"title"];
        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate predicateWithLeftExpression:lhs rightExpression:rhs modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        
        NSCompoundPredicate *orMatchPredicates = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
        [andMatchPredicates addObject:orMatchPredicates];
    }
    
    NSCompoundPredicate *finalCompoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    searchResults = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate]mutableCopy];
    
    // hand over the filtered results to out search results collectionview
    CMBSearchResultsController *collectionviewController = (CMBSearchResultsController *)self.searchController.searchResultsController;
    collectionviewController.filteredProfiles = searchResults;
    NSLog(@"%@", searchResults);
    [collectionviewController.collectionView reloadData];
    
}

@end
