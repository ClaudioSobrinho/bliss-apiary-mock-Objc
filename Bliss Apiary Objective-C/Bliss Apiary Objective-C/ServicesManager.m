//
//  ServicesManager.m
//  Bliss Apiary Objective-C
//
//  Created by Claudio Sobrinho on 3/24/17.
//  Copyright © 2017 Claudio Sobrinho. All rights reserved.
//

#import "ServicesManager.h"
#import "Choice.h"

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

#pragma mark - Services
- (void) checkServerHealth:(void (^)(BOOL isAlive))success
                   failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    [self GET:[BaseURL stringByAppendingString:Health]
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             
        NSLog(@"✅checkServerHealth✅: %@", responseObject);
        success(YES);
             
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"🔴checkServerHealth🔴: %@", error);
        failure(operation, error);
        
    }];
}

- (void) getQuestions:(NSNumber *)numberOfQuestions
           withFilter:(NSString *)filter
            andOffset:(NSNumber *)offset
              success:(void (^)(NSMutableArray *questionArray))success
              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    
    NSDictionary *parameters = @{@"limit" : numberOfQuestions == nil ? @10 : numberOfQuestions,
                                 @"offset" : offset == nil ? @0 : offset,
                                 @"filter" : filter == nil ? @"" : filter};
    
    [self GET:[BaseURL stringByAppendingString:Questions]
   parameters:parameters
     progress:nil
      success:^(NSURLSessionTask *task, id responseObject) {
          
          NSLog(@"✅getQuestions✅: %@", responseObject);
          
          NSMutableArray *questionArray = [[NSMutableArray alloc] init];
          
          if ([responseObject isKindOfClass:[NSArray class]]){
              for (NSDictionary *dictionary in responseObject) {
                  Question *question = [[Question alloc] init];
                  question.questionID = [dictionary objectForKey:@"id"];
                  question.question = [dictionary objectForKey:@"question"];
                  question.imageURL = [dictionary objectForKey:@"image_url"];
                  question.thumbURL = [dictionary objectForKey:@"thumb_url"];
                  question.publishDate = [dictionary objectForKey:@"published_at"];
                  
                  NSArray *choicesDictionaryArray = dictionary[@"choices"];
                  if ([choicesDictionaryArray isKindOfClass:[NSArray class]]){
                      for (NSDictionary *dictionary in choicesDictionaryArray) {
                          Choice *choice = [[Choice alloc] init];
                          choice.choice = [dictionary objectForKey:@"choice"];
                          choice.voteCount = @([[dictionary objectForKey:@"votes"] integerValue]);
                          [question.choicesArray addObject:choice];
                      }
                  }
                  [questionArray addObject:question];
              }
          }
          success(questionArray);
          
      } failure:^(NSURLSessionTask *operation, NSError *error) {
          
          NSLog(@"🔴getQuestions🔴: %@", error);
          failure(operation, error);
          
      }];
}

- (void) getQuestion:(NSNumber *)questionID
             success:(void (^)(Question *question))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    
    [self GET:[[BaseURL stringByAppendingString:QuestionID] stringByAppendingString:[questionID stringValue]]
   parameters:nil
     progress:nil
      success:^(NSURLSessionTask *task, id responseObject) {
          
          NSLog(@"✅getQuestion✅: %@", responseObject);
          
          //NSError *error;
          //NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
          
          if ([responseObject isKindOfClass:[NSDictionary class]]){
              Question *question = [[Question alloc] init];
              question.questionID = @([[responseObject objectForKey:@"id"] integerValue]);
              question.question = [responseObject objectForKey:@"question"];
              question.imageURL = [responseObject objectForKey:@"image_url"];
              question.thumbURL = [responseObject objectForKey:@"thumb_url"];
              question.publishDate = [responseObject objectForKey:@"published_at"];
              
              NSArray *choicesDictionaryArray = responseObject[@"choices"];
              if ([choicesDictionaryArray isKindOfClass:[NSArray class]]){
                  for (NSDictionary *dictionary in choicesDictionaryArray) {
                      Choice *choice = [[Choice alloc] init];
                      choice.choice = [dictionary objectForKey:@"choice"];
                      choice.voteCount = @([[dictionary objectForKey:@"votes"] integerValue]);
                      [question.choicesArray addObject:choice];
                  }
              }
              success(question);
          }
      } failure:^(NSURLSessionTask *operation, NSError *error) {
          
          NSLog(@"🔴getQuestion🔴: %@", error);
          failure(operation, error);
          
      }];
}

- (void) postQuestion:(Question *)question{
    NSArray *choicesArray = question.choicesArray;
    
    NSMutableDictionary *choicesDictionary = [[NSMutableDictionary alloc] initWithCapacity:[choicesArray count]];
    
    for (Choice *choice in choicesArray){
        [choicesDictionary setObject:choice.choice forKey:@"choice"];
    }

    NSDictionary *parameters = @{@"question" : question.question,
                                 @"image_url" : question.imageURL,
                                 @"thumb_url" : question.thumbURL,
                                 @"choices" : choicesDictionary};
    
    [self POST:[BaseURL stringByAppendingString:Questions]
    parameters:parameters
      progress:^(NSProgress * _Nonnull uploadProgress) {
      } 
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSLog(@"✅postQuestion✅: %@", responseObject);
       }
     
       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           NSLog(@"🔴postQuestion🔴: %@", error);
      }];
}

- (void) putQuestion:(Question *)question{
    NSArray *choicesArray = question.choicesArray;
    
    NSMutableDictionary *choicesDictionary = [[NSMutableDictionary alloc] initWithCapacity:[choicesArray count]];
    
    for (Choice *choice in choicesArray){
        [choicesDictionary setObject:choice.choice forKey:@"choice"];
        [choicesDictionary setObject:choice.voteCount forKey:@"votes"];
    }
    
    NSDictionary *parameters = @{@"id" : question.questionID,
                                 @"image_url" : question.imageURL,
                                 @"thumb_url" : question.thumbURL,
                                 @"question" : question.question,
                                 @"choices" : choicesDictionary};
    
    [self POST:[BaseURL stringByAppendingString:Questions]
    parameters:parameters
      progress:^(NSProgress * _Nonnull uploadProgress) {
          
      }
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSLog(@"✅putQuestion✅: %@", responseObject);
       }
     
       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           NSLog(@"🔴putQuestion🔴: %@", error);
       }];
}

- (void) share:(NSString *)destinationEmail
       content:(NSString *)contentURL{
    
    NSDictionary *parameters = @{@"destination_email" : destinationEmail,
                                 @"content_url" : contentURL};
    
    [self POST:[BaseURL stringByAppendingString:Share]
    parameters:parameters
      progress:^(NSProgress * _Nonnull uploadProgress) {
          
      }
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSLog(@"✅share✅: %@", responseObject);
       }
     
       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           NSLog(@"🔴share🔴: %@", error);
       }];
}

@end
