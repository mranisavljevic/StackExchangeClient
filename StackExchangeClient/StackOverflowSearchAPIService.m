//
//  StackOverflowSearchAPIService.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "StackOverflowSearchAPIService.h"
#import "JSONRequestService.h"

@implementation StackOverflowSearchAPIService

+ (void)searchQuestionsWithTerm:(NSString *)searchTerm page:(int)page completion:(kNSDictionaryCompletionHandler)completion {
    NSString *searchURL = @"https://api.stackexchange.com/2.2/search";
    
    NSString *pageNumber = (page < 1 ? pageNumber = @"1" : [NSString stringWithFormat:@"%i", page]);
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:pageNumber forKey:@"page"];
    [parameters setObject:searchTerm forKey:@"intitle"];
    [parameters setObject:@"stackoverflow" forKey:@"site"];
    [parameters setObject:@"activity" forKey:@"sort"];
    [parameters setObject:@"desc" forKey:@"order"];
//    NSLog(@"%@?page=%@&intitle=%@&site=stackoverflow&sort=activity&order=desc", searchURL, [parameters objectForKey:@"page"], [parameters objectForKey:@"intitle"]);
    [JSONRequestService GETRequestWithURLString:searchURL parameters:parameters completion:^(NSData *data, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        NSDictionary *results = (NSDictionary *)data;
        completion(results, nil);
        return;
    }];
}

@end
