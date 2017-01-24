//
//  OSStoreCollectionViewController.h
//  OnlineStore
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSStoreCollectionViewController : UIViewController
@property (nonatomic, copy) NSString *itemsWithStatus;
@property (nonatomic, copy) NSString *searchText;

-(void) reloadCollection;
@end
