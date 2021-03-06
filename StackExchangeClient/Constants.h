//
//  Constants.h
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "UIKit/UIKit.h"
#import "MyUser.h"
#ifndef Constants_h
#define Constants_h

typedef void(^kNSDataCompletionHandler)(NSData *data, NSError *error);
typedef void(^kNSDictionaryCompletionHandler)(NSDictionary *dictionary, NSError *error);
typedef void(^kNSArrayCompletionHandler)(NSArray *array, NSError *error);
typedef void(^kUIImageCompletionHandler)(UIImage *image, NSError *error);
typedef void(^kMyUserCompletionHandler)(MyUser *myUser, NSError *error);
typedef void(^kIdCompletionHandler)(id responseObject, NSError *error);

#endif /* Constants_h */
