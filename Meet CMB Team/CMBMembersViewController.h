//
//  MembersViewController.h
//  Meet CMB Team
//
//  Created by Mingyuan Wang on 11/11/16.
//  Copyright © 2016 Mingyuan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMBMembersViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;

@end