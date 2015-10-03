//
//  KMMainContentTabViewController.m
//  TheMovieDB
//
//  Created by long nguyen on 26/09/2015.
//  Copyright (c) Năm 2015 iKode Ltd. All rights reserved.
//

#import "KMMainContentTabViewController.h"
#import "KMMenuCollectionViewCell.h"
#import "KMMenuHeaderCollectionViewCell.h"
#import "TFHpple.h"
#import "KMSubMenu.h"
#import "KMMovieDetailsViewController.h"


#define kVerticalMarginForCollectionViewItems 0

@interface KMMainContentTabViewController (){
      NSData *htmlData;
}

@end

@implementation KMMainContentTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark View Lifecycle

- (void)awakeFromNib
{
     [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self setupCollectionViewLayout];
}

#pragma mark - data
#pragma mark -
#pragma mark data

-(void)loadData {
//    _webUrl = [NSURL URLWithString:@"http://tv.zing.vn/the-loai/Phim/IWZ9Z0DW.html"];
//    htmlData = [NSData dataWithContentsOfURL:_webUrl];
//    
//     self.moviesDataSource = [self getListMenuFavorite];
    
    _webUrl = [NSURL URLWithString:@"http://tv.zing.vn/the-loai/Hanh-Dong-Phieu-Luu/IWZ9Z0FF.html"];
    htmlData = [NSData dataWithContentsOfURL:_webUrl];
    
    self.moviesDataSource = [self getListMenu];
    
}

- (NSMutableArray*)getListMenu
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    // 2
    TFHpple *htmlParser = [TFHpple hppleWithHTMLData:htmlData];
    
    // 3
    NSString *tutorialsXpathQueryString =  @"//div[@class='subtray block-item program-item']/div[@class='item']";
    
    
    NSMutableArray *tutorialsNodes = [NSMutableArray arrayWithArray: [htmlParser searchWithXPathQuery:tutorialsXpathQueryString]];
    
    // 4
    
    for (TFHppleElement *element in tutorialsNodes) {
        
        KMSubMenu *menu = [[KMSubMenu alloc]init];
        for (TFHppleElement *child in element.children) {
            
            if ([[child tagName] isEqualToString:@"a"] ) {
                menu.mnUrl = child.attributes[@"href"];
                 NSLog(@"menu mnUrl : %@", menu.mnUrl);
                for (TFHppleElement *child1 in child.children) {
                    if (child1.attributes[@"src"] != nil) {
                        menu.mnImgUrl = child1.attributes[@"src"];
//                        NSLog(@"menu Img : %@", menu.mnImgUrl);
                    }
                    
                }
                
            }
            
            if ([[child tagName] isEqualToString:@"div"] ) {
                for (TFHppleElement *child1 in child.children) {
                    //                     NSLog(@"child1 : %@", child1.content);
                    if ([child1.tagName isEqualToString:@"h4"]) {
                        menu.mnTitle = child1.content;
                    }else if([child1.tagName isEqualToString:@"h5"]){
                        
                        menu.mnDescription = child1.content;
                    }
                }
                
                
            }
            
        }
        NSLog(@"menu.mnDescription : %@  menu.mnImgUrl : %@ menu.mnTitle : %@ , menu.mnUrl : %@",menu.mnDescription ,menu.mnImgUrl , menu.mnTitle, menu.mnUrl  );
        if (menu.mnImgUrl != nil) {
            [arr addObject:menu];
        }
        
        
    }
    
    return arr;
}

- (NSMutableArray*)getListMenuFavorite
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    // 2
    TFHpple *htmlParser = [TFHpple hppleWithHTMLData:htmlData];
    
    // 3
    NSString *tutorialsXpathQueryString =  @"//div[@class='section-content fluid']/div[@id='_page_119']/div[@class='subtray']/div[@class='item']";
 
    
    NSMutableArray *tutorialsNodes = [NSMutableArray arrayWithArray: [htmlParser searchWithXPathQuery:tutorialsXpathQueryString]];
    
    // 4
    
    for (TFHppleElement *element in tutorialsNodes) {
        
         KMSubMenu *menu = [[KMSubMenu alloc]init];
        for (TFHppleElement *child in element.children) {
           
           
           
            if ([[child tagName] isEqualToString:@"a"] ) {
                    menu.mnUrl = child.attributes[@"href"];
                
                 for (TFHppleElement *child1 in child.children) {
                     if (child1.attributes[@"_src"] != nil) {
                         menu.mnImgUrl = child1.attributes[@"_src"];
//                         NSLog(@"menu Img : %@", menu.mnImgUrl);
                     }
            
                 }
            
            }
            
             if ([[child tagName] isEqualToString:@"div"] ) {
                 for (TFHppleElement *child1 in child.children) {
//                     NSLog(@"child1 : %@", child1.content);
                     if ([child1.tagName isEqualToString:@"h4"]) {
                          menu.mnTitle = child1.content;
                     }else if([child1.tagName isEqualToString:@"h5"]){
                        
                         menu.mnDescription = child1.content;
                     }
                }
                 
                 
            }
            
        }
          NSLog(@"menu.mnDescription : %@  menu.mnImgUrl : %@ menu.mnTitle : %@ , menu.mnUrl : %@",menu.mnDescription ,menu.mnImgUrl , menu.mnTitle, menu.mnUrl  );
        if (menu.mnImgUrl != nil) {
            [arr addObject:menu];
        }
        
        
    }
    
    return arr;
}


#pragma mark - colectionview view delegeate
#pragma mark -
#pragma mark CollectionView Layout

- (void)setupCollectionViewLayout
{
    UICollectionViewFlowLayout* interfaceBuilderFlowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    
    CGSize viewSize = self.view.bounds.size;
    
    CGFloat cellAspectRatio = interfaceBuilderFlowLayout.itemSize.height / interfaceBuilderFlowLayout.itemSize.width;
    
    UICollectionViewFlowLayout *flowLayoutPort = UICollectionViewFlowLayout.new;
    
    flowLayoutPort.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayoutPort.sectionInset = interfaceBuilderFlowLayout.sectionInset;
    flowLayoutPort.minimumInteritemSpacing = interfaceBuilderFlowLayout.minimumInteritemSpacing;
    flowLayoutPort.minimumLineSpacing = interfaceBuilderFlowLayout.minimumLineSpacing;
    
    if (floor(viewSize.width/interfaceBuilderFlowLayout.itemSize.width) <= 2){
        
        CGFloat itemHeight = (viewSize.width/2.0 - kVerticalMarginForCollectionViewItems) * cellAspectRatio;
        
        flowLayoutPort.itemSize = CGSizeMake(viewSize.width/2.0 - kVerticalMarginForCollectionViewItems, itemHeight);
        
    }else{
        
        CGFloat itemHeight = (viewSize.height/2.0 - kVerticalMarginForCollectionViewItems) * cellAspectRatio;
        
        flowLayoutPort.itemSize = CGSizeMake(viewSize.height/2.0 - kVerticalMarginForCollectionViewItems, itemHeight);
        
    }
    
    [self.collectionView setCollectionViewLayout:flowLayoutPort];
    
}

#pragma mark -
#pragma mark UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [self.moviesDataSource count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
     UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        KMMenuHeaderCollectionViewCell *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KMMenuHeaderCollectionViewCell" forIndexPath:indexPath];
        
        headerView.lbTitle.text = @"section 1";
        headerView.lbTitle.textColor = [UIColor whiteColor];
        reusableview = headerView;
    }
    return reusableview;
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
   
    KMMenuCollectionViewCell* cell = (KMMenuCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"KMMenuCollectionViewCell" forIndexPath:indexPath];
    
    
    KMSubMenu *menu = [self.moviesDataSource objectAtIndex:indexPath.item];
    [cell.bgImg sd_setImageWithURL:[NSURL URLWithString:menu.mnImgUrl]];
    return cell;
}

#pragma mark -
#pragma mark UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
     KMSubMenu *menu = [self.moviesDataSource objectAtIndex:indexPath.item];
   
    NSLog(@"item %ld mnImgUrl :%@",(long)indexPath.item ,menu.mnImgUrl);
       NSLog(@"item %ld mnTitle :%@",(long)indexPath.item ,menu.mnTitle);
       NSLog(@"item %ld mnUrl :%@",(long)indexPath.item ,menu.mnUrl);
    
    KMMovieDetailsViewController* viewController = (KMMovieDetailsViewController*)[StoryBoardUtilities viewControllerForStoryboardName:@"KMMovieDetailsStoryboard" class:[KMMovieDetailsViewController class]];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController.subMenu = menu;
}

@end
