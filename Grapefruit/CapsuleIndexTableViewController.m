//
//  CapsuleIndexTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 11/11/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "CapsuleIndexTableViewController.h"
#import "ApiManager.h"
#import "CapsuleInformationTableViewController.h"

@interface CapsuleIndexTableViewController() <ApiManagerDelegate>

- (IBAction)backButtonPressed:(id)sender;

@property (strong, nonatomic) ApiManager *sharedApiManager;
@property (strong, nonatomic) NSArray *capsules;

@end

@implementation CapsuleIndexTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.capsules = [NSArray new];
    
    self.sharedApiManager = [ApiManager sharedInstance];
    self.sharedApiManager.delegate = self;
    [self.sharedApiManager getCapsuleIndex:self.courseID];
}

#pragma mark - ApiManager Delegate

- (void)getCapsuleIndexSuccessful:(NSArray *)capsuleIndex
{
    self.capsules = capsuleIndex;
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
    return self.capsules.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellIdentifier = @"CourseCell";
    
//    CourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    NSDictionary *capsule = self.capsules[indexPath.row][@"capsule"];
//    cell.courseTitleLabel.text = capsule[@"name"];
    
    return nil;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSDictionary *capsule = self.capsules[indexPath.row];
    // TODO: Load capsule[@"id"];
}

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
