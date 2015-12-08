//
//  Question.h
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Question : NSObject

- (id)initWithQuestionId:(int)questionId title:(NSString *)title owner:(User *)owner creationDate:(NSDate *)creationDate lastActivityDate:(NSDate *)lastActivityDate viewCount:(int)viewCount score:(int)score answerCount:(int)answerCount acceptedAnswerId:(int)acceptedAnswerId link:(NSURL *)link isAnswered:(BOOL)isAnswered;

@end
