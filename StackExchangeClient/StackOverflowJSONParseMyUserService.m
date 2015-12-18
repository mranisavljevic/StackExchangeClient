//
//  StackOverflowJSONParseMyUserService.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "StackOverflowJSONParseMyUserService.h"

@implementation StackOverflowJSONParseMyUserService

+ (void)parseMyUserFromDictionary:(NSDictionary *)dictionary completion:(kMyUserCompletionHandler)completion {
    if ([dictionary objectForKey:@"items"]) {
        NSDictionary *myUserObject = [[dictionary objectForKey:@"items"] firstObject];
        if ([myUserObject objectForKey:@"badge_counts"]) {
            
            NSDictionary *badgeCountsObject = [myUserObject objectForKey:@"badge_counts"];
            NSString *bronze = [badgeCountsObject objectForKey:@"bronze"];
            NSString *silver = [badgeCountsObject objectForKey:@"silver"];
            NSString *gold = [badgeCountsObject objectForKey:@"gold"];
            NSString *reputation = [myUserObject objectForKey:@"reputation"];
            NSString *userId = [myUserObject objectForKey:@"user_id"];
            NSString *userType = [myUserObject objectForKey:@"user_type"];
            NSURL *imageUrl = [NSURL URLWithString:[myUserObject objectForKey:@"profile_image"]];
            NSString *displayName = [myUserObject objectForKey:@"display_name"];
            NSURL *link = [NSURL URLWithString:[myUserObject objectForKey:@"link"]];
            
            MyUser *myUser = [[MyUser alloc] initWithDisplayName:displayName userId:userId.intValue reputation:reputation.intValue userType:userType profileImageURL:imageUrl link:link bronzeBadges:bronze.intValue silverBadges:silver.intValue goldBadges:gold.intValue];
            
            if (myUser) {
                completion(myUser, nil);
                return;
            }
        }
    }
    NSError *error = [NSError errorWithDomain:@"Do you even exist!?!" code:2 userInfo:nil];
    completion(nil, error);
}

@end
