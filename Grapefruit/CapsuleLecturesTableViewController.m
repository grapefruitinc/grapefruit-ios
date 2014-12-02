//
//  CapsuleLectureIndexTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 11/25/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "CapsuleLecturesTableViewController.h"
#import "ApiManager.h"
#import "LectureNameTableViewCell.h"
#import "LectureTableViewController.h"

@interface CapsuleLecturesTableViewController () <ApiManagerDelegate>

- (IBAction)backButtonPressed:(id)sender;

@property (strong, nonatomic) NSArray *capsuleLectures;
@property (strong, nonatomic) ApiManager *apiManager;

@end

@implementation CapsuleLecturesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Lectures";
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.capsuleLectures = [NSArray new];
    self.apiManager = [ApiManager sharedInstance];
    self.apiManager.delegate = self;
    
    // TODO: Display loading spinner:
    
    [self.apiManager getCapsuleInformation:self.courseID capsule:self.capsuleID];
}

#pragma mark - ApiManager Delegate

- (void)getCapsuleInformationSuccessful:(NSDictionary *)capsuleInformation
{
    self.capsuleLectures = capsuleInformation[@"lectures"];
    [self.tableView reloadData];
    
    // TODO: Dismiss loading spinner:
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.capsuleLectures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LectureNameCell";
    
    LectureNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSDictionary *lecture = self.capsuleLectures[indexPath.row][@"lecture"];
    cell.lectureNameLabel.text = lecture[@"name"];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *lecture = self.capsuleLectures[indexPath.row][@"lecture"];
    
    LectureTableViewController *lectureTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LectureTableViewController"];
    lectureTableViewController.courseID = self.courseID;
    lectureTableViewController.capsuleID = self.capsuleID;
    lectureTableViewController.lectureID = [lecture[@"id"] integerValue];
    [self.navigationController showViewController:lectureTableViewController sender:self];
}

#pragma mark - User Interaction

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

