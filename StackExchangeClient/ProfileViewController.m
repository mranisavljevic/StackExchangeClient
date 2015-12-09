//
//  ProfileViewController.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/7/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "ProfileViewController.h"
#import "StackOverflowMyUserProfileAPIService.h"
#import "StackOverflowJSONParseMyUserService.h"
#import "MyUser.h"

@interface ProfileViewController ()

@property (strong, nonatomic) MyUser *myUser;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bronzeBadgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *silverBadgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *goldBadgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *reputationLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.profileImageView setClipsToBounds:YES];
    self.profileImageView.layer.cornerRadius = 15.0;
    [self loadMyUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setMyUser:(MyUser *)myUser {
    _myUser = myUser;
    self.nameLabel.text = myUser.displayName;
    self.reputationLabel.text = [NSString stringWithFormat:@"Reputation: %i", myUser.reputation];
    self.bronzeBadgeLabel.text = [NSString stringWithFormat:@"%i", myUser.bronzeBadges];
    self.silverBadgeLabel.text = [NSString stringWithFormat:@"%i", myUser.silverBadges];
    self.goldBadgeLabel.text = [NSString stringWithFormat:@"%i", myUser.goldBadges];
    
    [self downloadProfileImage:myUser];
}

- (void)loadMyUser {
    [StackOverflowMyUserProfileAPIService fetchMyProfileInfoWithCompletion:^(NSDictionary *dictionary, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        if (dictionary) {
            [StackOverflowJSONParseMyUserService parseMyUserFromDictionary:dictionary completion:^(MyUser *myUser, NSError *error) {
                if (error) {
                    NSLog(@"%@", error.localizedDescription);
                    return;
                }
                if (myUser) {
                    [self setMyUser:myUser];
                }
            }];
        }
    }];
}

- (void)downloadProfileImage:(MyUser *)myUser {
    dispatch_queue_t imageQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(imageQueue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:myUser.profileImageURL];
        UIImage *profileImage = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.myUser.profileImage = profileImage;
            self.profileImageView.image = profileImage;
        });
    });
}

@end
