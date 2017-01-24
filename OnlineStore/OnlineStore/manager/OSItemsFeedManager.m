//
//  OSItemsFeedManager.m
//  OnlineStore
//
//  This class handles all the url fetching for the items
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "OSItemsFeedManager.h"


@implementation OSItemsFeedManager

-(void) getItemsFor:(NSString *) status {
    
    if([status isEqualToString:STATUS_CHECKED_OUT]) {
        self.items = @[];
        [self.delegate itemsFetched:@[]];
        return;
    }
    
    // hard coded url for items json
    NSString *itemsUrl = @"https://omniprojects.github.io/omni-ios-sample/api/items.json";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *itemsData = [NSData dataWithContentsOfURL:[NSURL URLWithString:itemsUrl]];
        if(itemsData == nil) {
            [self.delegate itemsFetched:@[]];
            return;
        }
        NSError *e = nil;
        NSDictionary *itemsJson = [NSJSONSerialization JSONObjectWithData:itemsData options:NSJSONReadingMutableContainers error:&e];
        NSArray *itemsArray = [itemsJson objectForKey:@"content"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.items = itemsArray;
            [self.delegate itemsFetched:itemsArray];

        });
    });
    
}

-(NSArray *) searchItemsFor:(NSString *) aQueryString {
    
    if(aQueryString == nil || [@"" isEqualToString:aQueryString]) {
        return self.items;
    }
    NSMutableArray *searchItems = [[NSMutableArray alloc] init];
    for(int i=0; i<self.items.count; i++) {
        NSString *title = [[self.items[i] objectForKey:@"title"] lowercaseString];
        if([title containsString:[aQueryString lowercaseString]]) {
            [searchItems addObject:self.items[i]];
        }
    }
    return searchItems;
}

@end
