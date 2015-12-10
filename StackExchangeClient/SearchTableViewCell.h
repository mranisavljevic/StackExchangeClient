//
//  SearchTableViewCell.h
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackExchangeClient-Swift.h"
#import "User.h"

@interface SearchTableViewCell : UITableViewCell

@property (strong, nonatomic) SwiftQuestion *question;
@property (strong, nonatomic) User *user;

@end
