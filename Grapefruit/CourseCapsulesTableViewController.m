//
//  CourseCapsulesTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 11/11/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "CourseCapsulesTableViewController.h"
#import "ApiManager.h"
#import "CapsuleNameTableViewCell.h"

//#import "CapsuleTableViewController.h"
#import "LectureIndexTableViewController.h"

@interface CourseCapsulesTableViewController() <ApiManagerDelegate>

- (IBAction)backButtonPressed:(id)sender;

@property (strong, nonatomic) ApiManager *sharedApiManager;

@end

@implementation CourseCapsulesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courseCapsules.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CapsuleNameCell";
    
    CapsuleNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSDictionary *capsule = self.courseCapsules[indexPath.row][@"capsule"];
    cell.capsuleNameLabel.text = capsule[@"name"];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *capsule = self.courseCapsules[indexPath.row][@"capsule"];
    NSInteger capsuleID = [capsule[@"id"] integerValue];
    
    LectureIndexTableViewController *lectureIndexTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LectureIndexTableViewController"];
    lectureIndexTableViewController.courseID = self.courseID;
    lectureIndexTableViewController.capsuleID = capsuleID;
    [self.navigationController showViewController:lectureIndexTableViewController sender:self];
}

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
