//
//  OSMainStorePageViewController.m
//  OnlineStore
//
//  This is a PageViewController holder for the items collection view pages (one for each status)
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "OSMainStorePageViewController.h"
#import "OSStoreCollectionViewController.h"
#import "OSItemsFeedManager.h"

@interface OSMainStorePageViewController ()<UIPageViewControllerDelegate>

    @property (nonatomic, strong) NSMutableDictionary *contentViewControllers;

@end

@implementation OSMainStorePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentViewControllers = [[NSMutableDictionary alloc] init];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = (id)self;
    [[self.pageController view] setFrame:[[self view] bounds]];    
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (OSStoreCollectionViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    // if already page is loaded, do not reload it.
    if(self.contentViewControllers.count == 0 || (int)index > self.contentViewControllers.count - 1 || [self.contentViewControllers objectForKey:[NSString stringWithFormat:@"%d", (int)index]] == nil) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        OSStoreCollectionViewController* childViewController = [sb instantiateViewControllerWithIdentifier:@"MainStoreItemsCollection"];
        //childViewController.itemsWithStatus = [self getItemStatus:(int)index];
        return childViewController;
    }
    
    OSStoreCollectionViewController *childViewController = [self.contentViewControllers objectForKey:[NSString stringWithFormat:@"%d", (int)index]];
   
       return childViewController;
}

-(void) goToIndex: (int) index searchText:(NSString *) aSearchText {
    
    OSStoreCollectionViewController *initialViewController = [self viewControllerAtIndex:index];
    initialViewController.searchText = aSearchText;
    initialViewController.itemsWithStatus = [self getItemStatus:index];
    [self.contentViewControllers setObject:initialViewController forKey:[NSString stringWithFormat:@"%d", index]];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    [initialViewController reloadCollection];
    
}

-(NSString *) getItemStatus: (int) index {
    if(index == 0) {
        return STATUS_CHECKED_IN;
    }
    return STATUS_CHECKED_OUT;
}


@end
