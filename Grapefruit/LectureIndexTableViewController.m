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

@interface LectureIndexTableViewController () <ApiManagerDelegate>

- (IBAction)backButtonPressed:(id)sender;

@property (strong, nonatomic) NSArray *capsuleLectures;
@property (strong, nonatomic) ApiManager *apiManager;

@end

@implementation LectureIndexTableViewController

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
    
    LectureInformationTableViewController *lectureInformationTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LectureInformationTableViewController"];
    lectureInformationTableViewController.courseID = self.courseID;
    lectureInformationTableViewController.capsuleID = self.capsuleID;
    lectureInformationTableViewController.lectureID = [lecture[@"id"] integerValue];
    [self.navigationController showViewController:lectureInformationTableViewController sender:self];
}

#pragma mark - User Interaction

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

