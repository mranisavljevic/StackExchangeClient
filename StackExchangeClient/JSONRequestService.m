//
//  JSONRequestService.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "JSONRequestService.h"
#import <AFNetworking/AFNetworking.h>

@implementation JSONRequestService

+ (void)GETRequestWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(kIdCompletionHandler)completion {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSOperationQueue *managerQueue = [manager operationQueue];
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [managerQueue setSuspended:NO];
                break;
            default:
                [managerQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        completion(responseObject, nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

@end
