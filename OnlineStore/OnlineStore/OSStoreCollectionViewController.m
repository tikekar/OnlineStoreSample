//
//  OSStoreCollectionViewController.m
//  OnlineStore
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "OSStoreCollectionViewController.h"
#import "OSItemsFeedManager.h"
#import "OSStoreCollectionViewCell.h"
#import "OSItemDetailsViewController.h"
#import "SVProgressHUD.h"

@interface OSStoreCollectionViewController () <OSItemsFeedManagerDelegate>
@property (nonatomic, strong) OSItemsFeedManager *feedManager;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *items;
@property (weak, nonatomic) IBOutlet UIView *emptyListView;
@end

@implementation OSStoreCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emptyListView.hidden = YES;
    self.collectionView.hidden = NO;
    
    self.feedManager = [[OSItemsFeedManager alloc] init];
    self.feedManager.delegate = (id)self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void) reloadCollection {
    [SVProgressHUD show];
    if(self.feedManager != nil && self.feedManager.items != nil && self.feedManager.items.count > 0) {
        
        self.items = [self.feedManager searchItemsFor:self.searchText];
        [self itemsFetched:self.items];
        
    }
    else {
        [self.feedManager getItemsFor:self.itemsWithStatus];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) itemsFetched:(NSArray*) aItems {
    self.items = aItems;
    [SVProgressHUD dismiss];
    if(self.items == nil || self.items.count == 0) {
        self.emptyListView.hidden = NO;
        self.collectionView.hidden = YES;
    }
    else {
        self.emptyListView.hidden = YES;
        self.collectionView.hidden = NO;
        [self.collectionView reloadData];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * const reuseIdentifier = @"StoreCollectionCell";
    OSStoreCollectionViewCell* cell = (OSStoreCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.itemDetails = self.items[indexPath.row];
    [cell loadDetails];
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"Show Item Details" sender:self.items[indexPath.row]];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[OSItemDetailsViewController class]]) {
        OSItemDetailsViewController *vc = (OSItemDetailsViewController *) segue.destinationViewController;
        vc.itemDetails = sender;
    }
   
}


@end
