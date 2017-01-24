//
//  OSCheckoutViewController.m
//  OnlineStore
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "OSCheckoutViewController.h"

@interface OSCheckoutViewController ()

@end

@implementation OSCheckoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.topViewController.title = @"Checkout";
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = nil;
    self.navigationController.topViewController.navigationItem.hidesBackButton = YES;
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
