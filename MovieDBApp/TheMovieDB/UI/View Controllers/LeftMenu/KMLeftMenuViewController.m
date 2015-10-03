//
//  KMLeftMenuViewController.m
//  TheMovieDB
//
//  Created by long on 9/21/15.
//  Copyright © 2015 iKode Ltd. All rights reserved.
//

#import "KMLeftMenuViewController.h"
#import "MFSideMenu.h"

@interface KMLeftMenuViewController ()

@end

@implementation KMLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - table delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = @"cel";
    switch (indexPath.row) {
        case 0:
             cell.textLabel.text = @"Phim đã đánh dấu";
            break;
        case 1:
             cell.textLabel.text = @"Phim Điện Ảnh";
            break;
        case 2:
             cell.textLabel.text = @"Phim Truyền Hình";
            break;
        case 3:
             cell.textLabel.text = @"Phim Hoạt Hình";
            break;
        case 4:
             cell.textLabel.text = @"TV Show";
            break;
        case 5:
             cell.textLabel.text = @"Hài";
            break;
            
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  KMMainMenuViewController * mainVc =  [StoryBoardUtilities viewControllerForStoryboardName:@"KMSlideMenustoryboard" class:[KMMainMenuViewController class]];
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            mainVc.keyPath = kPathDrama;
            break;
        case 3:
              mainVc.keyPath = kPathAnime;
            break;
        case 4:
              mainVc.keyPath = kPathTVShow;
            break;
        case 5:
              mainVc.keyPath = kPathFunny;
            break;
            
        default:
            break;
    }
     self.menuContainerViewController.centerViewController = [[UINavigationController alloc]initWithRootViewController:mainVc];
     [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}
 


@end
