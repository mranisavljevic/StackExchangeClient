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

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMyUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMyUser:(MyUser *)myUser {
    _myUser = myUser;
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

@end
