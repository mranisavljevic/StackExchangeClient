//
//  User.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "User.h"

@interface User ()

@property int reputation;
@property int userId;
@property (strong, nonatomic) NSString *userType;
@property int acceptRate;
@property (strong, nonatomic) NSURL *profileImageURL;
@property (strong, nonatomic) UIImage *profileImage;
@property (strong, nonatomic) NSString *displayName;
@property (strong, nonatomic) NSURL *link;

@end

@implementation User

- (id)initWithDisplayName:(NSString *)displayName userId:(int)userId reputation:(int)reputation userType:(NSString *)userType acceptRate:(int)acceptRate profileImageURL:(NSURL *)profileImageURL link:(NSURL *)link {
    
    if (self = [super init]) {
        [self setDisplayName:displayName];
        [self setUserId:userId];
        [self setReputation:reputation];
        [self setUserType:userType];
        [self setAcceptRate:acceptRate];
        [self setProfileImageURL:profileImageURL];
        [self setLink:link];
    }
    return self;
}

@end

