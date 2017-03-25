//
//  Question.h
//  Bliss Apiary Objective-C
//
//  Created by Claudio Sobrinho on 3/25/17.
//  Copyright © 2017 Claudio Sobrinho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Choice.h"

@interface Question : NSObject

@property (strong, nonatomic) NSNumber *questionID;
@property (strong, nonatomic) NSString *question;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *thumbURL;
@property (strong, nonatomic) NSString *publishDate;
@property (strong, nonatomic) NSMutableArray *choicesArray;

@end
