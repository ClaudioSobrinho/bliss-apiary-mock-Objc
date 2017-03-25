//
//  LoadingViewController.m
//  Bliss Apiary Objective-C
//
//  Created by Claudio Sobrinho on 3/23/17.
//  Copyright © 2017 Claudio Sobrinho. All rights reserved.
//

#import "LoadingViewController.h"
#import "ServicesManager.h"
#import "Question.h"
#import "Choice.h"
#import "DGActivityIndicatorView.h"
#import "QuestionListViewController.h"

@interface LoadingViewController ()
@property (weak, nonatomic) IBOutlet UIView *loaderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loaderViewHeigh;
@property (weak, nonatomic) IBOutlet UIImageView *warningImageView;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UIButton *retryButton;

@end

@implementation LoadingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self.loader startAnimating];
//TODO: Clean tests
//    [[ServicesManager sharedManager] checkServerHealth];
//    [[ServicesManager sharedManager] getQuestions:@10 withFilter:@""];
//    [[ServicesManager sharedManager] getQuestion:@4];
    
//    Question *question = [[Question alloc] init];
//    question.questionID = @2;
//    question.question = @"Ja papa perguntas?";
//    question.imageURL = @"";
//    question.thumbURL = @"";
//    
//    Choice *choice = [[Choice alloc] init];
//    choice.choice = @"sim";
//    
//    [question.choicesArray addObject:choice];
//    
//    [[ServicesManager sharedManager] putQuestion:question];
    
//    [[ServicesManager sharedManager] share:@"" content:@""];
    
//    Question *question = [[ServicesManager sharedManager] getQuestion:@4];
//    NSLog(@"✅Object✅: %@", question.question);

//    [[ServicesManager sharedManager] getQuestion:@4
//                                         success:^(Question *question){
//                                             NSLog(@"✅Object✅: %@", question.question);
//                                         }
//                                         failure:^(NSURLSessionTask *task, NSError *error){
//                                             NSLog(@"🔴Object🔴: %@", error);
//                                         }];
    
//    [[ServicesManager sharedManager] getQuestions:nil
//                                       withFilter:nil
//                                        andOffset:nil
//                                          success:^(NSMutableArray *questionArray){
//                                              NSLog(@"✅Array✅:");
//                                              for (Question *question in questionArray) {
//                                                  NSLog(@"%@:%@", question.questionID, question.question);
//                                              }
//                                          }
//                                          failure:^(NSURLSessionTask *task, NSError *error){
//                                              NSLog(@"🔴Array🔴: %@", error);
//                                          }];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self startLoader];
    [self checkServerHealth];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)didClickRetryButton:(UIButton *)sender{
    [self checkServerHealth];
}


#pragma mark - Auxiliar methods
- (void)startLoader{
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallTrianglePath tintColor:[UIColor darkGrayColor] size:50.0f];
    activityIndicatorView.frame = self.loaderView.frame;
    activityIndicatorView.center = CGPointMake(CGRectGetMidX(self.loaderView.bounds), CGRectGetMidY(self.loaderView.bounds));
    
    [self.loaderView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}

- (void)dismissLoader{
    [self.view layoutIfNeeded];
    
    self.loaderViewHeigh.constant = -100;
    
    [UIView animateWithDuration:5
                     animations:^{
                         [self.view layoutIfNeeded];
                         self.loaderView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             QuestionListViewController *vc = (QuestionListViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"QuestionListViewController"];
                             [self presentViewController:vc animated:YES completion:nil];
                         }
                     }];
}

- (void)showErrorView{
    self.loaderView.hidden = YES;
    self.warningImageView.hidden = NO;
    self.warningLabel.hidden = NO;
    self.retryButton.hidden = NO;
}

#pragma mark - Services
- (void)checkServerHealth{
    [[ServicesManager sharedManager] checkServerHealth:^(BOOL isAlive){
        NSLog(@"✅checkServerHealth✅:");
        [self dismissLoader];
    }
                                               failure:^(NSURLSessionTask *task, NSError *error){
                                                   NSLog(@"🔴checkServerHealth🔴: %@", error);
                                                   [self showErrorView];
                                               }];
}
@end
