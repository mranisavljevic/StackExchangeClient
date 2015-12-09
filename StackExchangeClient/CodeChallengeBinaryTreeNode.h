//
//  CodeChallengeBinaryTreeNode.h
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/9/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeChallengeBinaryTreeNode : NSObject

@property (strong, nonatomic) NSString *value;
@property int key;
@property (strong, nonatomic) CodeChallengeBinaryTreeNode *left;
@property (strong, nonatomic) CodeChallengeBinaryTreeNode *right;

- (id)initWithValue:(NSString *)value forKey:(int)key;

@end
