//
//  OSMeTabViewController.m
//  OnlineStore
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "OSMeTabViewController.h"
#import "OSLoginManager.h"
#import "UIImageView+WebCache.h"
#import "OSLoginManager.h"

@interface OSMeTabViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation OSMeTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationController.navigationBar.hidden = NO;
    OSUser *user = [OSLoginManager getUser];
    if(user != nil) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:nil options:SDWebImageRefreshCached];
        self.userNameLabel.text = [NSString stringWithFormat:@"Hello %@ %@", user.firstName, user.lastName];
    }

}

-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.topViewController.title = @"My Favorite Items";
    self.navigationController.topViewController.title = @"Me";
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutTapped)];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = logoutButton;
    self.navigationController.topViewController.navigationItem.hidesBackButton = YES;
    self.navigationController.topViewController.navigationItem.leftBarButtonItem = nil;
}

-(void) logoutTapped {
    [OSLoginManager logoutUser];
    [self performSegueWithIdentifier:@"Show Landing Page" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
