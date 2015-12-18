//
//  StackOverflowJSONParseSearchService.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "StackOverflowJSONParseSearchService.h"
#import "User.h"
#import "StackExchangeClient-Swift.h"

@implementation StackOverflowJSONParseSearchService

+ (void)parseQuestionsArrayFromDictionary:(NSDictionary *)dictionary completion:(kNSArrayCompletionHandler)completion {
    NSMutableArray *results = [NSMutableArray new];
    NSArray *itemsArray = (NSArray *)[dictionary objectForKey:@"items"];
    for (NSDictionary *item in itemsArray) {
        User *owner;
        if ([item objectForKey:@"owner"]) {
            NSDictionary *ownerObject = [item objectForKey:@"owner"];
            NSString *reputation = [ownerObject objectForKey:@"reputation"];
            NSString *userId = [ownerObject objectForKey:@"user_id"];
            NSString *userType = [ownerObject objectForKey:@"user_type"];
            NSString *acceptRate = [ownerObject objectForKey:@"accept_rate"];
            NSURL *imageUrl = [NSURL URLWithString:[ownerObject objectForKey:@"profile_image"]];
            NSString *displayName = [ownerObject objectForKey:@"display_name"];
            NSURL *link = [NSURL URLWithString:[ownerObject objectForKey:@"link"]];
            
            owner = [[User alloc] initWithDisplayName:displayName userId:userId.intValue reputation:reputation.intValue userType:userType acceptRate:acceptRate.intValue profileImageURL:imageUrl link:link];
            
            NSString *questionId = [item objectForKey:@"question_id"];
            NSString *title = [item objectForKey:@"title"];
            NSString *creationDateString = [item objectForKey:@"creation_date"];
            NSString *lastActivityDateString = [item objectForKey:@"last_activity_date"];
            NSDate *creationDate = [NSDate dateWithTimeIntervalSince1970:creationDateString.doubleValue];
            NSDate *lastActivityDate = [NSDate dateWithTimeIntervalSince1970:lastActivityDateString.doubleValue];
            NSString *viewCount = [item objectForKey:@"view_count"];
            NSString *score = [item objectForKey:@"score"];
            NSString *answerCount = [item objectForKey:@"answer_count"];
            NSString *acceptedAnswerId = [item objectForKey:@"accepted_answer_id"];
            NSURL *questionLink = [NSURL URLWithString:[item objectForKey:@"link"]];
            NSString *isAnswered = [item objectForKey:@"is_answered"];
            
//            SwiftQuestion *question = [[SwiftQuestion alloc] initWithQuestionId:questionId.intValue title:title owner:owner creationDate:creationDate lastActivityDate:lastActivityDate viewCount:viewCount.intValue score:score.intValue answerCount:answerCount.intValue acceptedAnswerId:acceptedAnswerId.intValue link:questionLink isAnswered:isAnswered.boolValue];
            SwiftQuestion *question = [[SwiftQuestion alloc] initWithQuestionId:questionId.intValue title:title owner:owner creationDate:creationDate lastActivityDate:lastActivityDate viewCount:viewCount.intValue score:score.intValue answerCount:answerCount.intValue acceptedAnswerId:acceptedAnswerId.intValue link:questionLink isAnswered:isAnswered.boolValue];
            
            [results addObject:question];
        }
    }
    if (results.count > 0) {
        completion(results, nil);
    } else {
        NSError *error = [NSError errorWithDomain:@"Oh, you are so bad at searching..." code:1 userInfo:nil];
        completion(nil, error);
    }
}

@end


