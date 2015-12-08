//
//  StackOverflowSearchAPIService.h
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface StackOverflowSearchAPIService : NSObject

+ (void)searchQuestionsWithTerm:(NSString *)searchTerm page:(int)page completion:(kNSDictionaryCompletionHandler)completion;

@end
