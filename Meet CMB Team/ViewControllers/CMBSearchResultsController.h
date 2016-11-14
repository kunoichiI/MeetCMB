//
//  CMBSearchResultsController.h
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/13/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBSearchResultsController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) NSArray *filteredProfiles;
@property (nonatomic) UICollectionView *collectionView;

@end