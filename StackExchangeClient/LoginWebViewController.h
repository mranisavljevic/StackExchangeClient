//
//  LoginWebViewController.h
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/7/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^webViewCompletion)(void);

@interface LoginWebViewController : UIViewController

@property (copy, nonatomic) webViewCompletion completion;

@end
