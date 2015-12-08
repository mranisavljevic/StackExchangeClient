//
//  User.h
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

@import UIKit;

@interface User : NSObject

- (id)initWithDisplayName:(NSString *)displayName userId:(int)userId reputation:(int)reputation userType:(NSString *)userType acceptRate:(int)acceptRate profileImageURL:(NSURL *)profileImageURL link:(NSURL *)link;


@end

