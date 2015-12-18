//
//  CodeChallengeBinaryTreeNode.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/9/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "CodeChallengeBinaryTreeNode.h"

@implementation CodeChallengeBinaryTreeNode

- (id)initWithValue:(NSString *)value forKey:(int)key {
    self = [super init];
    if (self) {
        [self setValue:value];
        [self setKey:key];
        [self setLeft:nil];
        [self setRight:nil];
    }
    return self;
}

@end
