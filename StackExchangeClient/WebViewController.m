//
//  WebViewController.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/9/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "WebViewController.h"
@import WebKit;

@interface WebViewController () <UIWebViewDelegate>

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)forwardButtonPressed:(UIBarButtonItem *)sender;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
    [self setUpWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpWebView {
    self.webView.delegate = self;
    if (self.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    }
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    if (self.completion) {
        self.completion();
    }
}

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)forwardButtonPressed:(UIBarButtonItem *)sender {
    [self.webView goForward];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.backButton.enabled = [webView canGoBack] ? YES : NO;
    self.forwardButton.enabled = [webView canGoForward] ? YES : NO;
}

@end


