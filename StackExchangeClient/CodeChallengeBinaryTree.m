//
//  CodeChallengeBinaryTree.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/9/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "CodeChallengeBinaryTree.h"

@interface CodeChallengeBinaryTree ()

@property (strong, nonatomic) CodeChallengeBinaryTreeNode *rootNode;
- (CodeChallengeBinaryTreeNode *)insertNode:(CodeChallengeBinaryTreeNode *)newNode atNode:(CodeChallengeBinaryTreeNode *)node;
- (NSString *)searchTreeForKey:(int)key atNode:(CodeChallengeBinaryTreeNode *)node;

@end

@implementation CodeChallengeBinaryTree

- (void)insertNode:(CodeChallengeBinaryTreeNode *)node {
    self.rootNode = [self insertNode:node atNode:self.rootNode];
}

- (CodeChallengeBinaryTreeNode *)insertNode:(CodeChallengeBinaryTreeNode *)newNode atNode:(CodeChallengeBinaryTreeNode *)node {
    if (!node) {
        return newNode;
    } else {
        CodeChallengeBinaryTreeNode *originalNode = node;
        if (newNode.key > node.key) {
            originalNode.right = [self insertNode:newNode atNode:node.right];
        } else {
            originalNode.left = [self insertNode:newNode atNode:node.left];
        }
        return originalNode;
    }
}

- (NSString *)searchTreeForKey:(int)key {
    return [self searchTreeForKey:key atNode:self.rootNode];
}

- (NSString *)searchTreeForKey:(int)key atNode:(CodeChallengeBinaryTreeNode *)node {
    if (!node) {
        return nil;
    } else {
        if (key == node.key) {
            return node.value;
        } else {
            if (key > node.key) {
                return [self searchTreeForKey:key atNode:node.right];
            } else {
                return [self searchTreeForKey:key atNode:node.left];
            }
        }
    }
}

+ (void)testBinaryTree {
    CodeChallengeBinaryTreeNode *node1 = [[CodeChallengeBinaryTreeNode alloc] initWithValue:@"What" forKey:7];
    CodeChallengeBinaryTreeNode *node2 = [[CodeChallengeBinaryTreeNode alloc] initWithValue:@"Am" forKey:4];
    CodeChallengeBinaryTreeNode *node3 = [[CodeChallengeBinaryTreeNode alloc] initWithValue:@"I" forKey:76];
    CodeChallengeBinaryTreeNode *node4 = [[CodeChallengeBinaryTreeNode alloc] initWithValue:@"Doing" forKey:27];
    CodeChallengeBinaryTreeNode *node5 = [[CodeChallengeBinaryTreeNode alloc] initWithValue:@"With" forKey:22];
    CodeChallengeBinaryTreeNode *node6 = [[CodeChallengeBinaryTreeNode alloc] initWithValue:@"This" forKey:90];
    CodeChallengeBinaryTreeNode *node7 = [[CodeChallengeBinaryTreeNode alloc] initWithValue:@"Binary" forKey:2];
    CodeChallengeBinaryTreeNode *node8 = [[CodeChallengeBinaryTreeNode alloc] initWithValue:@"Search" forKey:44];
    CodeChallengeBinaryTreeNode *node9 = [[CodeChallengeBinaryTreeNode alloc] initWithValue:@"Tree" forKey:68];
    CodeChallengeBinaryTreeNode *node10 = [[CodeChallengeBinaryTreeNode alloc] initWithValue:@"Test" forKey:87];
    
    CodeChallengeBinaryTree *binaryTree = [[CodeChallengeBinaryTree alloc] init];
    
    [binaryTree insertNode:node1];
    [binaryTree insertNode:node2];
    [binaryTree insertNode:node3];
    [binaryTree insertNode:node4];
    [binaryTree insertNode:node5];
    [binaryTree insertNode:node6];
    [binaryTree insertNode:node7];
    [binaryTree insertNode:node8];
    [binaryTree insertNode:node9];
    [binaryTree insertNode:node10];
    
    NSLog(@"%@", [binaryTree searchTreeForKey:7]);
    NSLog(@"%@", [binaryTree searchTreeForKey:4]);
    NSLog(@"%@", [binaryTree searchTreeForKey:76]);
    NSLog(@"%@", [binaryTree searchTreeForKey:27]);
    NSLog(@"%@", [binaryTree searchTreeForKey:22]);
    NSLog(@"%@", [binaryTree searchTreeForKey:90]);
    NSLog(@"%@", [binaryTree searchTreeForKey:2]);
    NSLog(@"%@", [binaryTree searchTreeForKey:44]);
    NSLog(@"%@", [binaryTree searchTreeForKey:68]);
    NSLog(@"%@", [binaryTree searchTreeForKey:87]);
    NSLog(@"%@", [binaryTree searchTreeForKey:23] ? @"!" : @"?");
    
}

@end
