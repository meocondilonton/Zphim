//
//  KMMovieDetailsViewController.h
//  TheMovieDB
//
//  Created by Kevin Mindeguia on 04/02/2014.
//  Copyright (c) 2014 iKode Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMDetailsPageView.h"
#import "KMMovie.h"
#import "KMGillSansLabel.h"
#import "KMNetworkLoadingViewController.h"
#import "KMSubMenu.h"
#import "KMBaseViewController.h"
#import "KMMovieDetailsCell.h"
#import <QuartzCore/QuartzCore.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface KMMovieDetailsViewController : KMBaseViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, KMNetworkLoadingViewDelegate, KMDetailsPageDelegate,KMMovieDetailsCellProtocal>

@property (weak, nonatomic) IBOutlet UIView *navigationBarView;
@property (weak, nonatomic) IBOutlet UIView *networkLoadingContainerView;
@property (weak, nonatomic) IBOutlet KMDetailsPageView* detailsPageView;
@property (weak, nonatomic) IBOutlet KMGillSansLightLabel *navBarTitleLabel;

@property (strong, nonatomic) KMMovie* movieDetails;
@property (strong, nonatomic) KMSubMenu* subMenu;

@property (assign, nonatomic)BOOL isFavorite ;

- (IBAction)popViewController:(id)sender;

@end
