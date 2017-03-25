//
//  QuestionListViewController.m
//  Bliss Apiary Objective-C
//
//  Created by Claudio Sobrinho on 3/25/17.
//  Copyright © 2017 Claudio Sobrinho. All rights reserved.
//

#import "QuestionListViewController.h"
#import "ServicesManager.h"
#import "Question.h"
#import "DetailViewController.h"
#import "ShareViewController.h"

@interface QuestionListViewController() <UISearchBarDelegate, UISearchDisplayDelegate>
@property(strong,nonatomic) NSMutableArray *questionArray;
@property (weak, nonatomic) IBOutlet UITableView *questionsTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchTextField;
- (IBAction)didClickShareButton:(UIBarButtonItem *)sender;
@end

@implementation QuestionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Questions Screen";
    [self getQuestions:nil];
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

#pragma mark - TableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.questionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Question *question = [self.questionArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = question.question;
    return cell;
}

#pragma mark - Searchbar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length >= 2) {
        [self getQuestions:searchText];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *vc = (DetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    vc.question = self.questionArray[indexPath.row];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Actions
- (IBAction)didClickShareButton:(UIBarButtonItem *)sender {
    ShareViewController *vc = (ShareViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
    vc.searchQuery = self.searchTextField.text;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Services
- (void)getQuestions:(NSString *)filter{
        [[ServicesManager sharedManager] getQuestions:nil
                                           withFilter:nil
                                            andOffset:nil
                                              success:^(NSMutableArray *questionArray){
                                                  NSLog(@"✅Array✅:");
                                                  self.questionArray = questionArray;
                                                  [self.questionsTableView reloadData];
                                              }
                                              failure:^(NSURLSessionTask *task, NSError *error){
                                                  NSLog(@"🔴Array🔴: %@", error);
                                              }];
}


@end
