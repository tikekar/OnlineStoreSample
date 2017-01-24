//
//  OSLoginManager.m
//  OnlineStore
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "OSLoginManager.h"
#import "OSUser.h"

static OSUser *sharedInstance = nil;
@implementation OSLoginManager

+ (void) loginUser:(NSString *) aEmail password:(NSString *) aPassword completionHandler:(void (^) (OSUser *user, NSError *error))handler; {
    // To instantiate current logged in user
    
    if(sharedInstance == nil) {
        
        NSString *loginUrl = @"https://omniprojects.github.io/omni-ios-sample/api/login.json";
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData *loginData = [NSData dataWithContentsOfURL:[NSURL URLWithString:loginUrl]];
            if(loginData == nil) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(sharedInstance, nil);
                });
                return;
            }
            NSError *e = nil;
            NSDictionary *loginJson = [NSJSONSerialization JSONObjectWithData:loginData options:NSJSONReadingMutableContainers error:&e];
            NSDictionary *userDetails = [loginJson objectForKey:@"content"];
            NSString *email = [userDetails objectForKey:@"email"];
            if([aEmail isEqualToString:email]) {
                sharedInstance = [[OSUser alloc] init];
                sharedInstance.email = email;
                sharedInstance.firstName = [userDetails objectForKey:@"first_name"];
                sharedInstance.lastName = [userDetails objectForKey:@"last_name"];
                sharedInstance.avatar = [userDetails objectForKey:@"avatar"];
                [[NSUserDefaults standardUserDefaults] setObject:userDetails forKey:@"loggedInUser"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(sharedInstance, nil);
                return;
            });
        });
        return;
    }
    handler(sharedInstance, nil);
   
}

+ (OSUser *) getUser {
    
    if(sharedInstance != nil)  {
        return sharedInstance;
    }
    // Fetch the user from nsuserdefaults and create the OSUser object
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDetails = [prefs objectForKey:@"loggedInUser"];
    if(userDetails == nil) {
        return nil;
    }
    sharedInstance = [[OSUser alloc] init];
    sharedInstance.email = [userDetails objectForKey:@"email"];
    sharedInstance.firstName = [userDetails objectForKey:@"first_name"];
    sharedInstance.lastName = [userDetails objectForKey:@"last_name"];
    sharedInstance.avatar = [userDetails objectForKey:@"avatar"];
    return sharedInstance;
}

+ (void) logoutUser {
    sharedInstance = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loggedInUser"];
}
@end
