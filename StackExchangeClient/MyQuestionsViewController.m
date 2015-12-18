//
//  MyQuestionsViewController.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/7/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "MyQuestionsViewController.h"
#import "StackOverflowMyQuestionsAPIService.h"
#import "StackOverflowJSONParseSearchService.h"
#import "MyQuestionsTableViewCell.h"
#import "StackExchangeClient-Swift.h"
#import "User.h"
#import "WebViewController.h"
@import SafariServices;


@interface MyQuestionsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myQuestionsTableView;
@property (weak, nonatomic) IBOutlet UILabel *noQuestionsWarningLabel;
@property (strong, nonatomic) NSArray *myQuestions;

@end

@implementation MyQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myQuestionsTableView.dataSource = self;
    self.myQuestionsTableView.delegate = self;
    self.myQuestionsTableView.estimatedRowHeight = 100;
    self.myQuestionsTableView.rowHeight = UITableViewAutomaticDimension;
    self.noQuestionsWarningLabel.hidden = YES;
    UINib *nib = [UINib nibWithNibName:@"MyQuestionsTableViewCell" bundle:nil];
    [self.myQuestionsTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self fetchMyQuestions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setMyQuestions:(NSArray *)myQuestions {
    _myQuestions = myQuestions;
    [self.myQuestionsTableView reloadData];
}

- (void)fetchMyQuestions {
    [StackOverflowMyQuestionsAPIService fetchMyQuestions:1 completion:^(NSDictionary *dictionary, NSError *error) {
        if (error) {
            NSLog(@"You have not asked any questions, or there is some other problem.");
            self.noQuestionsWarningLabel.hidden = NO;
            return;
        }
        [StackOverflowJSONParseSearchService parseQuestionsArrayFromDictionary:dictionary completion:^(NSArray *array, NSError *error) {
            if (error) {
                NSLog(@"There was some problem parsing...");
                self.noQuestionsWarningLabel.hidden = NO;
                return;
            }
            self.noQuestionsWarningLabel.hidden = YES;
            [self setMyQuestions:array];
        }];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WebViewController"]) {
        if ([segue.destinationViewController isKindOfClass:[WebViewController class]]) {
            WebViewController *webViewController = (WebViewController *)segue.destinationViewController;
            if ([sender isKindOfClass:[NSURL class]]) {
                NSURL *url = (NSURL *)sender;
                webViewController.url = url;
            }
            webViewController.completion = ^() {
                [self dismissViewControllerAnimated:YES completion:nil];
            };
        }
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.myQuestions.count > 0 ? self.myQuestions.count : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyQuestionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    SwiftQuestion *question = (SwiftQuestion *)self.myQuestions[indexPath.row];
    [cell setQuestion:question];
    cell.layer.cornerRadius = 10.0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SwiftQuestion *question = (SwiftQuestion *)self.myQuestions[indexPath.row];
    NSURL *url = (NSURL *)question.link;
    if ([SFSafariViewController class]) {
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:url];
        [self presentViewController:safariViewController animated:YES completion:nil];
    } else {
        [self performSegueWithIdentifier:@"WebViewController" sender:url];
    }
}

@end
