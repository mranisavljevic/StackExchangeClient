//
//  User.h
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

@import UIKit;

@interface User : NSObject

@property int reputation;
@property int userId;
@property (strong, nonatomic) NSString *userType;
@property int acceptRate;
@property (strong, nonatomic) NSURL *profileImageURL;
@property (strong, nonatomic) UIImage *profileImage;
@property (strong, nonatomic) NSString *displayName;
@property (strong, nonatomic) NSURL *link;

- (id)initWithDisplayName:(NSString *)displayName userId:(int)userId reputation:(int)reputation userType:(NSString *)userType acceptRate:(int)acceptRate profileImageURL:(NSURL *)profileImageURL link:(NSURL *)link;


@end

