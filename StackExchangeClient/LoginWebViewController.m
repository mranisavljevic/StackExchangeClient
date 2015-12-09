//
//  LoginWebViewController.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/7/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "LoginWebViewController.h"
#import "KeychainService.h"
@import WebKit;

NSString const *kStackExchangeBaseURL = @"https://stackexchange.com/oauth/dialog?";
NSString const *kStackExchangeClientID = @"6110";
NSString const *kStackExchangeRedirictURI = @"https://stackexchange.com/oauth/login_success";

@interface LoginWebViewController () <WKNavigationDelegate>

@property WKWebView *webView;

@end

@implementation LoginWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    [self.webView setNavigationDelegate:self];
    NSString *oAuthURLString = [NSString stringWithFormat:@"%@client_id=%@&redirect_uri=%@",kStackExchangeBaseURL, kStackExchangeClientID, kStackExchangeRedirictURI];
    NSURL *oAuthURL = [NSURL URLWithString:oAuthURLString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:oAuthURL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURLRequest *request = navigationAction.request;
    NSURL *url = request.URL;

    if ([url.description containsString:@"access_token"]) {
        NSArray *description = [url.description componentsSeparatedByString:@"access_token="];
        NSString *authTokenAndExpiration = description.lastObject;
        NSString *authToken = [authTokenAndExpiration componentsSeparatedByString:@"&"].firstObject;
        [KeychainService save:authToken];
        if (self.completion) {
            self.completion();
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
