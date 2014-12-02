//
//  CourseInstructorsTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 12/2/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "CourseInstructorsTableViewController.h"
#import "InstructorTableViewCell.h"
#import <MessageUI/MessageUI.h>

@interface CourseInstructorsTableViewController () <MFMailComposeViewControllerDelegate>

- (IBAction)backButtonPressed:(id)sender;

@end

@implementation CourseInstructorsTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.courseInstructors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"InstructorCell";
    InstructorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSDictionary *instructor = self.courseInstructors[indexPath.row];
    cell.instructorNameLabel.text = instructor[@"name"];
    cell.instructorEmailLabel.text = instructor[@"email"];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *instructor = self.courseInstructors[indexPath.row];
    NSString *email = instructor[@"email"];
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[email]];
        [composeViewController setSubject:@""];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

#pragma mark - MFMailComposeViewController Delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // TODO: Add an alert in the case of failure.
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - User Interaction

- (IBAction)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
