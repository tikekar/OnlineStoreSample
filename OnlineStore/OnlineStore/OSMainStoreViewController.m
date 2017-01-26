//
//  OSMainStoreViewController.m
//  OnlineStore
//
//  Main Store page outer View
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "OSMainStoreViewController.h"
#import "OSMainStorePageViewController.h"

@interface OSMainStoreViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *itemStatusSegmentedButton;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation OSMainStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.itemStatusSegmentedButton.selectedSegmentIndex = 0;
    [self showChildViewControllerAt:0 searchText:nil];
}

-(void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    self.navigationController.topViewController.title = @"My Favorite Items";
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchTapped)];
   
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = searchButton;
    self.navigationController.topViewController.navigationItem.hidesBackButton = YES;
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = nil;
}

-(void) searchTapped {
    if(self.searchView.frame.origin.y >= 0) {
        [self hideSearchView];
        return;
    }
    [self showSearchView];
}

-(void) showSearchView {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame;
        frame.origin.x = self.searchView.frame.origin.x;
        frame.origin.y = self.searchView.frame.origin.y + self.searchView.frame.size.height;
        frame.size = self.searchView.frame.size;
        self.searchView.frame = frame;
        [self.searchTextField becomeFirstResponder];
    } completion:^(BOOL finished) {
        
    }];

}

-(void) hideSearchView {
    [self.searchTextField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame;
        frame.origin.x = self.searchView.frame.origin.x;
        frame.origin.y = self.searchView.frame.origin.y - self.searchView.frame.size.height;
        frame.size = self.searchView.frame.size;
        self.searchView.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.searchTextField) {
        [self.searchTextField resignFirstResponder];
        [self showChildViewControllerAt:(int)self.itemStatusSegmentedButton.selectedSegmentIndex searchText:textField.text];
        if(textField.text != nil && ![textField.text isEqualToString:@""]) {
            return NO;
        }
        [self hideSearchView];

        return NO;
    }
    return YES;
}

-(BOOL) textFieldShouldClear:(UITextField *)textField {
    [self showChildViewControllerAt:(int)self.itemStatusSegmentedButton.selectedSegmentIndex searchText:nil];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (IBAction)onStatusValueChange:(id)sender {
    [self showChildViewControllerAt:(int)self.itemStatusSegmentedButton.selectedSegmentIndex searchText:self.searchTextField.text];
}

-(void) showChildViewControllerAt : (int) index searchText:(NSString *) aSearchText{
    
    OSMainStorePageViewController *tbc = (OSMainStorePageViewController *)self.childViewControllers[0];
    
    [tbc goToIndex:index searchText:aSearchText];
    
}

@end
