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
#import "Question.h"
#import "User.h"

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

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.myQuestions.count > 0 ? self.myQuestions.count : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyQuestionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Question *question = (Question *)self.myQuestions[indexPath.row];
    [cell setQuestion:question];
    cell.layer.cornerRadius = 10.0;
    return cell;
}

@end
