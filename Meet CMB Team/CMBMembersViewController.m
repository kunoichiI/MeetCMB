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

static NSString * const photoCellIdentifier = @"ProfileCell";
@interface CMBMembersViewController () <UICollectionViewDelegate>
@property(nonatomic) AVAudioPlayer *player;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) CMBSearchResultsController *resultsCollectionController;

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
    
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.searchController.searchBar.placeholder = @"Search people here";
    
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
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *path = [NSString stringWithFormat:@"%@/sound.mp3", resourcePath];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    self.player.numberOfLoops = 0;
    self.player.delegate = self;
    [self.player play];
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
    
- (void) updateFilteredContentForNameOrTitle:(NSString *)title name:(NSString *)name {
    if (title == nil && name == nil) { // if no input is detected
        self.searchResults = [self.profiles mutableCopy];
    } else if (title != nil) {
        NSMutableArray *searchResults = [[NSMutableArray alloc] init];
        for (NSDictionary *profile in self.profiles) {
            if ([profile[@"title"] containsString:title]) {
                CMBMemberProfile *member = [[CMBMemberProfile alloc]initWithTitle:profile[@"title"] firstName:profile[@"firstName"] lastName:profile[@"lastName"] avatar:profile[@"avatar"] number:profile[@"number"]];
                [searchResults addObject:member];
            }
            self.searchResults = searchResults;
        
        }
    }
}

@end
