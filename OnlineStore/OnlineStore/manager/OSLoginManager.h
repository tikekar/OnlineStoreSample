//
//  OSLoginManager.h
//  OnlineStore
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSUser.h"

@interface OSLoginManager : NSObject

+ (void) loginUser:(NSString *) aEmail password:(NSString *) aPassword completionHandler:(void (^) (OSUser *user, NSError *error))handler;
+ (OSUser *) getUser;
+ (void) logoutUser;

@end
