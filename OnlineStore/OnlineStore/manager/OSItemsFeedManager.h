//
//  OSItemsFeedManager.h
//  OnlineStore
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#define STATUS_CHECKED_IN @"Checked In"
#define STATUS_CHECKED_OUT @"Checked Out"

@protocol OSItemsFeedManagerDelegate <NSObject>

@required
- (void) itemsFetched:(NSArray*) aItems;

@end


@interface OSItemsFeedManager : NSObject

-(void) getItemsFor:(NSString *) status;
-(NSArray *) searchItemsFor:(NSString *) aQueryString;
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSArray *items;

@end
