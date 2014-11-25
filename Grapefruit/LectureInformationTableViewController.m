//
//  LectureInformationTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 11/25/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "LectureInformationTableViewController.h"
#import "ApiManager.h"

@interface LectureInformationTableViewController () <ApiManagerDelegate>

- (IBAction)backButtonPressed:(id)sender;

@property (strong, nonatomic) ApiManager *sharedApiManager;
@property (strong, nonatomic) NSDictionary *lectureInformation;

@end

@implementation LectureInformationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lectureInformation = [NSDictionary new];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.sharedApiManager = [ApiManager sharedInstance];
    self.sharedApiManager.delegate = self;
    [self.sharedApiManager getLectureInformation:self.courseID capsule:self.capsuleID lecture:self.lectureID];
}

#pragma mark - ApiManager Delegate

- (void)getLectureInformationSuccessful:(NSDictionary *)lectureInformation
{
    self.lectureInformation = lectureInformation;
    // TODO: Do stuff.
}

- (void)getLectureInformationFailedWithError:(NSError *)error
{
    
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
//    return self.lectures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellIdentifier = @"LectureNameCell";
//    
//    LectureNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    NSDictionary *lecture = self.lectures[indexPath.row][@"lecture"];
//    cell.lectureNameLabel.text = lecture[@"name"];
    
//    return cell;
    return nil;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    LectureInformationTableViewController *lectureInformationTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LectureInformationTableViewController"];
//    lectureInformationTableViewController
}

#pragma mark - User Interaction

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

