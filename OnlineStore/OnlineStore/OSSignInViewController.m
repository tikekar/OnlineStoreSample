//
//  OSSignInViewController.m
//  OnlineStore Login page with email and password texts
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "OSSignInViewController.h"
#import "OSUser.h"
#import "OSLoginManager.h"
#import "SVProgressHUD.h"

@interface OSSignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation OSSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [self.passwordTextField setSecureTextEntry:YES];
    [self.emailTextField becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onGoClick:(id)sender {
    [self loginUser];
}

-(void) loginUser {
    [SVProgressHUD show];
    [OSLoginManager loginUser:self.emailTextField.text password:self.passwordTextField.text completionHandler:^(OSUser *user, NSError *error) {
        [SVProgressHUD dismiss];
        if(user == nil) {
            // authentication failed.
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Authentication Failed" message:@"Please verify your email or password." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else {
            [self performSegueWithIdentifier:@"Show Online Store View" sender:nil];
        }
    }];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([self.passwordTextField isFirstResponder]){
        [self.passwordTextField resignFirstResponder];    //Resign the keyboard.
        [self loginUser];     //call your login method here.
    }
    //Below case when user taps return key when done with login info then we move focus from login textfield to password textfield so as not making user to do this and for ease of user.
    else{
        [self.emailTextField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
    }
    return YES;
}


@end
