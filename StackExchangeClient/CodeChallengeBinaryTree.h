//
//  CodeChallengeBinaryTree.h
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/9/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodeChallengeBinaryTreeNode.h"

@interface CodeChallengeBinaryTree : NSObject

- (void)insertNode:(CodeChallengeBinaryTreeNode *)node;
- (NSString *)searchTreeForKey:(int)key;
+ (void)testBinaryTree;

@end
