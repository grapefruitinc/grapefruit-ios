//
//  CourseListTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 10/21/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "CourseListTableViewController.h"
#import "CourseTableViewCell.h"
#import "CourseTableViewController.h"
#import "AppDelegate.h"
#import "ApiManager.h"

@interface CourseListTableViewController () <ApiManagerDelegate>

@end

@implementation CourseListTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    ApiManager *sharedApiManager = [ApiManager sharedInstance];
    sharedApiManager.delegate = self;
    [sharedApiManager getCourses];
}

#pragma mark - ApiManager Delegate

- (void)getCoursesSuccessful
{
    [self.tableView reloadData];
}

- (void)getCoursesFailedWithError:(NSError *)error
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
    ApiManager *sharedApiManager = [ApiManager sharedInstance];
    return sharedApiManager.courses.allKeys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"CourseCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[CourseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // TODO: Pull up correct course info.
    CourseTableViewController *courseTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseTableViewController"];
    [self.navigationController pushViewController:courseTableViewController animated:YES];
}

@end
