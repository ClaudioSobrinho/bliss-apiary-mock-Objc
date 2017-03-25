//
//  ServicesManager.h
//  Bliss Apiary Objective-C
//
//  Created by Claudio Sobrinho on 3/24/17.
//  Copyright © 2017 Claudio Sobrinho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Question.h"

#pragma mark - Service Paths
static NSString * const BaseURL = @"https://private-bbbe9-blissrecruitmentapi.apiary-mock.com/";

static NSString* const Health = @"health";
static NSString* const Questions = @"questions";
static NSString* const QuestionID = @"questions/";
static NSString* const Share = @"share";

#pragma mark - Interface Definition
@interface ServicesManager : AFHTTPSessionManager

+ (ServicesManager *) sharedManager;
- (void)checkServerHealth;
- (void) getQuestions:(NSNumber *)numberOfQuestions
           withFilter:(NSString *) filter;
- (void) getQuestion:(NSNumber *)questionID
             success:(void (^)(Question *question))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
- (void) postQuestion:(Question *)question;
- (void) putQuestion:(Question *)question;
- (void) share:(NSString *)destinationEmail
       content:(NSString *)contentURL;

@end
