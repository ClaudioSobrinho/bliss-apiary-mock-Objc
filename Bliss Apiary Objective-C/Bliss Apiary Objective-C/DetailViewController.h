//
//  DetailViewController.h
//  Bliss Apiary Objective-C
//
//  Created by Claudio Sobrinho on 3/25/17.
//  Copyright © 2017 Claudio Sobrinho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface DetailViewController : UIViewController
@property(strong,nonatomic)Question *question;
@end
