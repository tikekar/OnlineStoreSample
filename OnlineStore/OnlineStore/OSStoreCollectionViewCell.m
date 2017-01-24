//
//  OSStoreCollectionViewCell.m
//  OnlineStore
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "OSStoreCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation OSStoreCollectionViewCell


-(void) loadDetails {
    
    self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height/2;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 1.0f;
    NSString *imageUrl = [self.itemDetails objectForKey:@"image_thumbnail"];
    
    // TODO: To imgix urls @"%@?auto=enhance" can be appended to enhance the image quality.
    // Somehow we can remove the gradient background??
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil options:SDWebImageRefreshCached];
    self.titleLabel.text = [self.itemDetails objectForKey:@"title"];
}

@end
