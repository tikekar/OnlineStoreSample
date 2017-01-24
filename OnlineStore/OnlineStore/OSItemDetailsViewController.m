//
//  OSItemDetailsViewController.m
//  OnlineStore
//
//  Created by Gauri Tikekar on 1/18/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

#import "OSItemDetailsViewController.h"
#import "UIImageView+WebCache.h"

@interface OSItemDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *itemCategory;

@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UITextView *addNotesTextView;
@end

@implementation OSItemDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Hearts_Gray.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = searchButton;
    // To add placeholder text, better way is to extend TextView class??
    self.addNotesTextView.text = @"Add a private Note...";
    self.addNotesTextView.textColor = [UIColor lightGrayColor];
    self.addNotesTextView.delegate = (id)self;
    // Better to use OSItem object instead of directly using dictionary to get item details.
    if(self.itemDetails != nil) {
        self.itemTitle.text = [self.itemDetails objectForKey:@"title"];
        if([self.itemDetails objectForKey:@"status"] != nil) {
            self.itemCategory.text = [NSString stringWithFormat:@"%@ (status: %@)", [self.itemDetails objectForKey:@"category"], [self.itemDetails objectForKey:@"status"]];
        }
        else {
            self.itemCategory.text = [self.itemDetails objectForKey:@"category"];
        }
        [self addImages];
    }
    
}

-(void) addImages {
    NSArray* photos = [self.itemDetails objectForKey:@"images"];
    
    for (int i = 0; i < photos.count; i++)
    {
        CGRect frame;
        frame.origin.x = self.imageScrollView.frame.size.width * i;
        frame.origin.y = self.imageScrollView.frame.origin.y - 5;
        frame.size = self.imageScrollView.frame.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
       
         [imageView sd_setImageWithURL:[NSURL URLWithString:photos[i]] placeholderImage:nil options:SDWebImageRefreshCached];
        [self.imageScrollView addSubview:imageView];
    }
    
    self.imageScrollView.contentSize = CGSizeMake(self.imageScrollView.frame.size.width * photos.count, self.imageScrollView.frame.size.height);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    self.addNotesTextView.text = @"";
    self.addNotesTextView.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(self.addNotesTextView.text.length == 0){
        self.addNotesTextView.textColor = [UIColor lightGrayColor];
        self.addNotesTextView.text = @"Add a private Note...";
        [self.addNotesTextView resignFirstResponder];
    }
}

@end
