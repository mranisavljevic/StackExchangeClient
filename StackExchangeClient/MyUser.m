//
//  MyUser.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "MyUser.h"

@implementation MyUser

- (id)initWithDisplayName:(NSString *)displayName userId:(int)userId reputation:(int)reputation userType:(NSString *)userType profileImageURL:(NSURL *)profileImageURL link:(NSURL *)link bronzeBadges:(int)bronzeBadges silverBadges:(int)silverBadges goldBadges:(int)goldBadges {
    
    if (self = [super init]) {
        [self setDisplayName:displayName];
        [self setUserId:userId];
        [self setReputation:reputation];
        [self setUserType:userType];
        [self setProfileImageURL:profileImageURL];
        [self setLink:link];
        [self setBronzeBadges:bronzeBadges];
        [self setSilverBadges:silverBadges];
        [self setGoldBadges:goldBadges];
    }
    return self;
}

@end
