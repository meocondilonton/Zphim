//
//  KMAppDelegate.h
//  TheMovieDB
//
//  Created by Kevin Mindeguia on 03/02/2014.
//  Copyright (c) 2014 iKode Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMMainMenuViewController.h"
#import "KMLeftMenuViewController.h"

@interface KMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) KMMainMenuViewController * mainVc;
@property (strong, nonatomic) KMLeftMenuViewController * leftVc;
@property (strong,nonatomic)NSMutableArray *arrMenu;
@end
