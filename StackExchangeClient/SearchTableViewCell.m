//
//  SearchTableViewCell.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "Constants.h"
@import UIKit;

@interface SearchTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *questionTitleLabel;

@end

@implementation SearchTableViewCell

- (void)setQuestion:(Question *)question {
    self.user = question.owner;
    self.questionTitleLabel.text = question.title;
    if (self.user.profileImage) {
        self.profileImageView.image = self.user.profileImage;
    } else {
        [self downloadProfileImageWithCompletion:^(UIImage *image, NSError *error) {
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                self.profileImageView.image = [UIImage imageNamed:@"guy.png"];
            }
            self.user.profileImage = image;
            self.profileImageView.image = self.user.profileImage;
        }];
    }
}

- (void)awakeFromNib {
    self.profileImageView.layer.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)downloadProfileImageWithCompletion:(kUIImageCompletionHandler)completion {
    dispatch_queue_t imageDownloadeQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(imageDownloadeQueue, ^{
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.user.profileImageURL];
        UIImage *profileImage = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(profileImage, nil);
        });
    });
}

@end
