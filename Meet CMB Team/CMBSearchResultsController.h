//
//  CMBSearchResultsController.h
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/13/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBSearchResultsController : UIViewController
@property(nonatomic, strong) NSArray *filteredProfiles;
@property(nonatomic, strong) UICollectionView *collectionView;

@end
