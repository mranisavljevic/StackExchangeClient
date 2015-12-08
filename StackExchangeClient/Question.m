//
//  Question.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "Question.h"

@interface Question ()

@end

@implementation Question

- (id)initWithQuestionId:(int)questionId title:(NSString *)title owner:(User *)owner creationDate:(NSDate *)creationDate lastActivityDate:(NSDate *)lastActivityDate viewCount:(int)viewCount score:(int)score answerCount:(int)answerCount acceptedAnswerId:(int)acceptedAnswerId link:(NSURL *)link isAnswered:(BOOL)isAnswered {
    if (self = [super init]) {
        [self setQuestionId:questionId];
        [self setTitle:title];
        [self setOwner:owner];
        [self setCreationDate:creationDate];
        [self setLastActivityDate:lastActivityDate];
        [self setViewCount:viewCount];
        [self setScore:score];
        [self setAnswerCount:answerCount];
        [self setAcceptedAnswerId:acceptedAnswerId];
        [self setLink:link];
        [self setIsAnswered:isAnswered];
    }
    return self;
}

@end
