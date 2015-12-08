//
//  Question.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "Question.h"

@interface Question ()

@property int questionId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) User *owner;
@property (strong, nonatomic) NSDate *creationDate;
@property (strong, nonatomic) NSDate *lastActivityDate;
@property int viewCount;
@property int score;
@property int answerCount;
@property int acceptedAnswerId;
@property (strong, nonatomic) NSURL *link;
@property BOOL isAnswered;

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
