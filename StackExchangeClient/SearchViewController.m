//
//  SearchViewController.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/7/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "SearchViewController.h"
#import "StackOverflowSearchAPIService.h"
#import "StackOverflowJSONParseSearchService.h"
#import "Question.h"
#import "SearchTableViewCell.h"
#import "WebViewController.h"
@import SafariServices;

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchTableView.dataSource = self;
    self.searchTableView.delegate = self;
    self.searchTableView.estimatedRowHeight = 10;
    self.searchTableView.rowHeight = UITableViewAutomaticDimension;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Guy";
    UINib *nib = [UINib nibWithNibName:@"SearchTableViewCell" bundle:nil];
    [self.searchTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self searchQuestionsWithSearchTerm:@"Guy" page:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setSearchResults:(NSArray *)searchResults {
    _searchResults = searchResults;
    [self.searchTableView reloadData];
}

- (void)searchQuestionsWithSearchTerm:(NSString *)searchTerm page:(int)page {
    [StackOverflowSearchAPIService searchQuestionsWithTerm:searchTerm page:page completion:^(NSDictionary *dictionary, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        [StackOverflowJSONParseSearchService parseQuestionsArrayFromDictionary:dictionary completion:^(NSArray *array, NSError *error) {
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                return;
            }
            self.searchResults = array;
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

- (void)presentWKWebView:(NSURL *)url {
    [self performSegueWithIdentifier:@"WebViewController" sender:url];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.searchResults ? self.searchResults.count : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell *cell = (SearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Question *question = self.searchResults[indexPath.row];
    [cell setQuestion:question];
    cell.layer.cornerRadius = 10.0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Question *question = self.searchResults[indexPath.row];
    if ([SFSafariViewController class]) {
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:question.link entersReaderIfAvailable:NO];
        [self presentViewController:safariViewController animated:YES completion:nil];
    } else {
        [self presentWKWebView:question.link];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length > 0) {
        [self searchQuestionsWithSearchTerm:searchBar.text page:1];
    }
}

@end
