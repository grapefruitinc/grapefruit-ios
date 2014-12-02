//
//  CourseIndexTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 10/21/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "CourseIndexTableViewController.h"
#import "CourseTableViewCell.h"
#import "CourseTableViewController.h"
#import "AppDelegate.h"
#import "ApiManager.h"
#import "MenuTableViewController.h"

@interface CourseIndexTableViewController () <ApiManagerDelegate>

- (IBAction)menuButtonPressed:(id)sender;
@property (strong, nonatomic) ApiManager *sharedApiManager;
@property (strong, nonatomic) NSArray *courses;

@end

@implementation CourseIndexTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.courses = [NSArray new];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.sharedApiManager = [ApiManager sharedInstance];
    self.sharedApiManager.delegate = self;
    [self.sharedApiManager getCourseIndex];
}

#pragma mark - ApiManager Delegate

- (void)getCourseIndexSuccessful:(NSArray *)courseIndex
{
    self.courses = [courseIndex sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    [self.tableView reloadData];
}

- (void)getCourseIndexFailedWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"CourseCell";
    
    CourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[CourseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    NSDictionary *course = self.courses[indexPath.row];
    
    cell.courseTitleLabel.text = course[@"name"];
    NSString *courseNumberString = [NSString stringWithFormat:@"%@ %@ - %@ Credits", course[@"subject"], course[@"course_number"], course[@"credits"]];
    cell.courseNumberLabel.text = courseNumberString;
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // TODO: Pull up correct course info.
    CourseTableViewController *courseInformationTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseTableViewController"];
    courseInformationTableViewController.courseID = [self.courses[indexPath.row][@"id"] integerValue];
    courseInformationTableViewController.courseInformation = self.courses[indexPath.row];
    [self.navigationController pushViewController:courseInformationTableViewController animated:YES];
}

- (IBAction)menuButtonPressed:(id)sender {
    
    MenuTableViewController *menuTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuTableViewController"];
    menuTableViewController.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:menuTableViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
