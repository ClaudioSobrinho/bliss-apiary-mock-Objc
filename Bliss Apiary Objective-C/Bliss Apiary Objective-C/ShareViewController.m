//
//  ShareViewController.m
//  Bliss Apiary Objective-C
//
//  Created by Claudio Sobrinho on 3/25/17.
//  Copyright © 2017 Claudio Sobrinho. All rights reserved.
//

#import "ShareViewController.h"
#import "ServicesManager.h"

@interface ShareViewController ()
- (IBAction)didClickCloseButton:(UIBarButtonItem *)sender;
- (IBAction)didClickSendButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)didClickCloseButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)didClickSendButton:(UIButton *)sender {
    NSString *email = self.emailTextField.text;
    if (!self.questionID) {
        [self share:email withContent:self.searchQuery];
    }else{
        [self share:email withContent:[self.questionID stringValue]];
    }
}

- (void)share:(NSString *)email withContent:(NSString *) content{
    [[ServicesManager sharedManager] share:email content:content];
}
@end
