//
//  MyQuestionsTableViewCell.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/8/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "MyQuestionsTableViewCell.h"

@interface MyQuestionsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *creationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerCountLabel;


@end

@implementation MyQuestionsTableViewCell

- (void)awakeFromNib {
    self.contentView.layer.cornerRadius = 10.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setQuestion:(Question *)question {
    _question = question;
    self.titleLabel.text = question.title;
    self.creationDateLabel.text = [NSString stringWithFormat:@"Creation Date: %@", [NSDateFormatter localizedStringFromDate:question.creationDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle]];
    self.viewsCountLabel.text = [NSString stringWithFormat:@"Views: %i",question.viewCount];
    self.answerCountLabel.text = [NSString stringWithFormat:@"Answers: %i", question.answerCount];
}

@end
