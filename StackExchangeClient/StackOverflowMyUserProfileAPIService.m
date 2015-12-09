//
//  StackOverflowMyUserProfileAPIService.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "StackOverflowMyUserProfileAPIService.h"
#import "KeychainService.h"
#import "JSONRequestService.h"

@implementation StackOverflowMyUserProfileAPIService

+ (void)fetchMyProfileInfoWithCompletion:(kIdCompletionHandler)completion {
    NSString *searchURL = @"https://api.stackexchange.com/2.2/me";
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[KeychainService loadFromKeychain] forKey:@"access_token"];
    [parameters setObject:@"7YhjPpWyOPT97JvXSMUjwA((" forKey:@"key"];
    [parameters setObject:@"stackoverflow" forKey:@"site"];
    [parameters setObject:@"reputation" forKey:@"sort"];
    [parameters setObject:@"desc" forKey:@"order"];
    
//    NSLog(@"%@?access_token=%@&site=stackoverflow&sort=reputation&order=desc", searchURL, [KeychainService loadFromKeychain]);
    
    [JSONRequestService GETRequestWithURLString:searchURL parameters:parameters completion:^(id responseObject, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *results = (NSDictionary *)responseObject;
            completion(results, nil);
            return;
        } else {
            NSError *wrongTypeError = [NSError errorWithDomain:[NSString stringWithFormat:@"GET request returned unexpected datatype: %@", [responseObject class]] code:11 userInfo:nil];
            completion(nil, wrongTypeError);
            return;
        }
    }];
}

@end
