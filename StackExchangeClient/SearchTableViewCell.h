//
//  SearchTableViewCell.h
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "User.h"

@interface SearchTableViewCell : UITableViewCell

@property (strong, nonatomic) Question *question;
@property (strong, nonatomic) User *user;

@end
