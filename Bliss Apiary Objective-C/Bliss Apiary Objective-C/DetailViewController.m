//
//  DetailViewController.m
//  Bliss Apiary Objective-C
//
//  Created by Claudio Sobrinho on 3/25/17.
//  Copyright © 2017 Claudio Sobrinho. All rights reserved.
//

#import "DetailViewController.h"
#import "ShareViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *questionImageURLImageView;
@property (weak, nonatomic) IBOutlet UILabel *questionIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *firstChoiceButton;
@property (weak, nonatomic) IBOutlet UIButton *secondChoiceButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdChoiceButton;
@property (weak, nonatomic) IBOutlet UIButton *forthChoiceButton;
@property (weak, nonatomic) IBOutlet UILabel *firstChoiceCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondChoiceCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdChoiceCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *forthChoiceCountLabel;
- (IBAction)didClickBackButton:(UIBarButtonItem *)sender;
- (IBAction)didClickShareButton:(UIBarButtonItem *)sender;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.title = @"Detail Screen";
//    self.navigationItem.leftItemsSupplementBackButton = YES;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.questionIDLabel.text = [self.question.questionID stringValue];
    self.questionDateLabel.text = self.question.publishDate;
    self.questionLabel.text = self.question.question;
    
    //I know this is terrible, if you're seeing this, you've seen the rest of my code, it's pretty good... I know it's a bad excuse but, lack of time.
    self.firstChoiceButton.titleLabel.text = ((Choice *)self.question.choicesArray[0]).choice;
    self.secondChoiceButton.titleLabel.text = ((Choice *)self.question.choicesArray[1]).choice;
    self.thirdChoiceButton.titleLabel.text = ((Choice *)self.question.choicesArray[2]).choice;
    self.forthChoiceButton.titleLabel.text = ((Choice *)self.question.choicesArray[3]).choice;
    self.firstChoiceCountLabel.text = [((Choice *)self.question.choicesArray[0]).voteCount stringValue];
    self.secondChoiceCountLabel.text = [((Choice *)self.question.choicesArray[1]).voteCount stringValue];
    self.thirdChoiceCountLabel.text = [((Choice *)self.question.choicesArray[2]).voteCount stringValue];
    self.forthChoiceCountLabel.text = [((Choice *)self.question.choicesArray[3]).voteCount stringValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions
- (IBAction)didClickBackButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)didClickShareButton:(UIBarButtonItem *)sender {
    ShareViewController *vc = (ShareViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
    vc.questionID = self.question.questionID;
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end
