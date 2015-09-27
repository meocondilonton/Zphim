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
#import "KMMainContentTabViewController.h"

@interface KMMainMenuViewController () <ViewPagerDataSource, ViewPagerDelegate>{
      NSData *tutorialsHtmlData;
      NSUInteger numberOfTabs;
}



@end

@implementation KMMainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupMenuBarButtonItems];
//    [self loadData];
    [self getListMenu];
    
    self.dataSource = self;
    self.delegate = self;
    
    self.tabLocation =  [NSNumber numberWithFloat:1.0];
    
    self.title = @"View Pager";

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(loadContent) withObject:nil afterDelay:1.0];
    
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

#pragma mark - Overriding methods
#pragma mark -
#pragma mark -page menu

#pragma mark - Setters
- (void)setNumberOfTabs:(NSUInteger)numberOfTab {
    
    // Set numberOfTabs
    numberOfTabs = numberOfTab;
    
    // Reload data
    [self reloadData];
    
}

#pragma mark - Helpers
- (void)selectTabWithNumberFive {
    [self selectTabAtIndex:1];
}
- (void)loadContent {
    self.numberOfTabs = 1;
     self.tabLocation =  [NSNumber numberWithFloat:1.0];
}

#pragma mark - Interface Orientation Changes
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil afterDelay:duration];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return  numberOfTabs;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = [NSString stringWithFormat:@"Tab #%i", index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    KMMainContentTabViewController *cvc = (KMMainContentTabViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"KMSlideMenustoryboard" class:[KMMainContentTabViewController class]];
    
//    cvc.labelString = [NSString stringWithFormat:@"Content View #%i", index];
    
    return cvc;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 0.0;
        case ViewPagerOptionTabHeight:
            return 49.0;
        case ViewPagerOptionTabOffset:
            return 36.0;
        case ViewPagerOptionTabWidth:
            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 1.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 1.0;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.32];
        case ViewPagerContent:
            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
}


@end
