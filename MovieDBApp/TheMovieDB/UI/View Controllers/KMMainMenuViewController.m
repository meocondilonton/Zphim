//
//  KMMainViewController.m
//  TheMovieDB
//
//  Created by long on 9/21/15.
//  Copyright © 2015 iKode Ltd. All rights reserved.
//

#import "KMMainMenuViewController.h"
#import "KMSubMenu.h"
#import "TFHpple.h"

@interface KMMainMenuViewController (){
    NSData *tutorialsHtmlData;
}

@end

@implementation KMMainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupMenuBarButtonItems];
    [self loadData];
    [self getListMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark get data

-(void)loadData {
    NSURL *tutorialsUrl = [NSURL URLWithString:@"http://tv.zing.vn/the-loai/Phim/IWZ9Z0DW.html"];
    tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];

}

- (NSMutableArray*)getListMenu
{
     NSMutableArray *arr = [[NSMutableArray alloc]init];
    // 2
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
    
    // 3
    NSString *tutorialsXpathQueryString = @"//div[@class='sub-nav phim-truyen-hinh']";
    
    NSMutableArray *tutorialsNodes = [NSMutableArray arrayWithArray: [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString]];
    
    // 4
    
    for (TFHppleElement *element in tutorialsNodes) {
        for (TFHppleElement *child in element.children) {
            if ([[child objectForKey:@"class"] isEqualToString: @"sub-col"] || [[child objectForKey:@"class"] isEqualToString: @"sub-col last-column"]) {
                
             for (TFHppleElement *child1 in child.children) {
                 
                if ([[child1 tagName] isEqualToString:@"ul"]) {
             
                for (TFHppleElement *child2 in child1.children) {
                       if ([[child2 tagName] isEqualToString:@"li"]) {
                        for (TFHppleElement *child3 in child2.children) {

                              NSLog(@"title : %@",[child3 objectForKey:@"title"]);
                             NSLog(@"url : %@",[child3 objectForKey:@"href"]);
                            KMSubMenu *menu = [[KMSubMenu alloc]init];
                            menu.mnTitle = [child3 objectForKey:@"title"];
                            menu.mnUrl = [child3 objectForKey:@"href"];
                             [arr addObject:menu];
                            }
                       }
                    }
                 }
             }
        }

            
        }
        break;
       
        
    }

   
    
    
   
    
    return arr;
}

#pragma mark -
#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems {
    
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
    } else {
        self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    }
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(leftSideMenuButtonPressed:)];
}



- (UIBarButtonItem *)backBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(backButtonPressed:)];
}
#pragma mark - Overriding methods
#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}



@end
