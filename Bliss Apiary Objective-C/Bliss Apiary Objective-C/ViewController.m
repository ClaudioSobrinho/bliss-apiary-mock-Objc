//
//  ViewController.m
//  Bliss Apiary Objective-C
//
//  Created by Claudio Sobrinho on 3/23/17.
//  Copyright © 2017 Claudio Sobrinho. All rights reserved.
//

#import "ViewController.h"
#import "ServicesManager.h"
#import "Question.h"
#import "Choice.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
