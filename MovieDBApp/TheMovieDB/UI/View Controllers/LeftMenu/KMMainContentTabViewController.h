//
//  KMMainContentTabViewController.h
//  TheMovieDB
//
//  Created by long nguyen on 26/09/2015.
//  Copyright (c) Năm 2015 iKode Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMBaseViewController.h"

@interface KMMainContentTabViewController : KMBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray* moviesDataSource;
@property (strong, nonatomic) NSURL *webUrl;
@property (assign,nonatomic)BOOL isFavorite;

@end
