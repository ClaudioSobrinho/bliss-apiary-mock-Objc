//
//  ServicesManager.m
//  Bliss Apiary Objective-C
//
//  Created by Claudio Sobrinho on 3/24/17.
//  Copyright © 2017 Claudio Sobrinho. All rights reserved.
//

#import "ServicesManager.h"

@implementation ServicesManager

+ (ServicesManager *)sharedManager {
    static ServicesManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void) checkServerHealth {
    [self GET:[BaseURL stringByAppendingString:Health]
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             
        NSLog(@"✅JSON✅: %@", responseObject);
             
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"🔴Error🔴: %@", error);
        
    }];
}

- (void) getQuestions:(NSNumber *)numberOfQuestions
           withFilter:(NSString *) filter{
    NSDictionary *parameters = @{@"limit" : numberOfQuestions,
                                 @"offset" : @0,
                                 @"filter" : @""};
    
    [self GET:[BaseURL stringByAppendingString:Questions]
   parameters:parameters
     progress:nil
      success:^(NSURLSessionTask *task, id responseObject) {
          
          NSLog(@"✅JSON✅: %@", responseObject);
          
      } failure:^(NSURLSessionTask *operation, NSError *error) {
          
          NSLog(@"🔴Error🔴: %@", error);
          
      }];
}

- (void) getQuestion:(NSNumber *)questionID{
    [self GET:[[BaseURL stringByAppendingString:QuestionID] stringByAppendingString:[questionID stringValue]]
   parameters:nil
     progress:nil
      success:^(NSURLSessionTask *task, id responseObject) {
          
          NSLog(@"✅JSON✅: %@", responseObject);
          
      } failure:^(NSURLSessionTask *operation, NSError *error) {
          
          NSLog(@"🔴Error🔴: %@", error);
          
      }];
}

- (void) postQuestion:(NSNumber *)questionID{
    [self GET:[[BaseURL stringByAppendingString:QuestionID] stringByAppendingString:[questionID stringValue]]
   parameters:nil
     progress:nil
      success:^(NSURLSessionTask *task, id responseObject) {
          
          NSLog(@"✅JSON✅: %@", responseObject);
          
      } failure:^(NSURLSessionTask *operation, NSError *error) {
          
          NSLog(@"🔴Error🔴: %@", error);
          
      }];
}

@end
