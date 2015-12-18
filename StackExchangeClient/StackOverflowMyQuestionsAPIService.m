//
//  StackOverflowMyQuestionsAPIService.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "StackOverflowMyQuestionsAPIService.h"
#import "KeychainService.h"
#import "JSONRequestService.h"

@implementation StackOverflowMyQuestionsAPIService

+ (void)fetchMyQuestions:(int)page completion:(kNSDictionaryCompletionHandler)completion {
    NSString *searchURL = @"https://api.stackexchange.com/2.2/me/questions";
    
    NSString *pageNumber = (page < 1 ? pageNumber = @"1" : [NSString stringWithFormat:@"%i", page]);
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[KeychainService loadFromKeychain] forKey:@"access_token"];
    [parameters setObject:@"7YhjPpWyOPT97JvXSMUjwA((" forKey:@"key"];
    [parameters setObject:pageNumber forKey:@"page"];
    [parameters setObject:@"stackoverflow" forKey:@"site"];
    [parameters setObject:@"activity" forKey:@"sort"];
    [parameters setObject:@"desc" forKey:@"order"];
    
//    NSLog(@"%@?access_token=%@&key=7YhjPpWyOPT97JvXSMUjwA((&page=1&site=stackoverflow&sort=activity&order=desc", searchURL, [KeychainService loadFromKeychain]);
    
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
