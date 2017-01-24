//
//  OSMainStorePageViewController.h
//  OnlineStore
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSMainStorePageViewController : UIPageViewController

@property (nonatomic, strong) NSString *itemsWithStatus;
@property (strong, nonatomic) UIPageViewController *pageController;
-(void) goToIndex: (int) index searchText:(NSString *) aSearchText;

@end
