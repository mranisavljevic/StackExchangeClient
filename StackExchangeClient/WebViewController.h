//
//  WebViewController.h
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/9/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^webViewCompletion)();

@interface WebViewController : UIViewController

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) webViewCompletion completion;

@end
