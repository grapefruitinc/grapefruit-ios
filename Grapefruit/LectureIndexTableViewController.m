//
//  CapsuleLectureIndexTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 11/25/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "LectureIndexTableViewController.h"
#import "ApiManager.h"
#import "LectureNameTableViewCell.h"
#import "LectureInformationTableViewController.h"

@interface LectureIndexTableViewController ()

- (IBAction)backButtonPressed:(id)sender;

@property (strong, nonatomic) ApiManager *sharedApiManager;
@property (strong, nonatomic) NSArray *lectures;

@end

@implementation LectureIndexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lectures = [NSArray new];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.sharedApiManager = [ApiManager sharedInstance];
    self.sharedApiManager.delegate = self;
    [self.sharedApiManager getCapsuleInformation:self.courseID capsule:self.capsuleID];
}

#pragma mark - ApiManager Delegate

- (void)getCapsuleInformationSuccessful:(NSDictionary *)capsuleInformation
{
    self.lectures = capsuleInformation[@"lectures"];
    [self.tableView reloadData];
}

- (void)getCapsuleInformationFailedWithError:(NSError *)error
{
    
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lectures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LectureNameCell";
    
    LectureNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSDictionary *lecture = self.lectures[indexPath.row][@"lecture"];
    cell.lectureNameLabel.text = lecture[@"name"];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LectureInformationTableViewController *lectureInformationTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LectureInformationTableViewController"];
    lectureInformationTableViewController.courseID = self.courseID;
    lectureInformationTableViewController.capsuleID = self.capsuleID;
    lectureInformationTableViewController.lectureID = [self.lectures[indexPath.row][@"lecture"][@"id"] integerValue];
    [self.navigationController showViewController:lectureInformationTableViewController sender:self];
}

#pragma mark - User Interaction

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

