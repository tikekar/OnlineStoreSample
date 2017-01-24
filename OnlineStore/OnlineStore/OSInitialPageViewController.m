//
//  ViewController.m
//  OnlineStore
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "OSInitialPageViewController.h"
#import "OSLoginManager.h"
#import "OSUser.h"

@interface OSInitialPageViewController ()
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@end

@implementation OSInitialPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    OSUser *user = [OSLoginManager getUser];
    if(user != nil) {
        [self performSegueWithIdentifier:@"Show Items View" sender:nil];
    }
}

- (IBAction)onSignInButtonClick:(id)sender {
   
    [self performSegueWithIdentifier:@"Show SignIn View" sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
