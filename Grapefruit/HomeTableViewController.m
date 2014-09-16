//
//  HomeTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 9/15/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "HomeTableViewController.h"
#import "CourseTableViewCell.h"
#import "CourseTableViewController.h"
#import "AppDelegate.h"
#import "RESideMenu.h"

@interface HomeTableViewController ()

- (IBAction)menuButtonPressed:(id)sender;
- (IBAction)newButtonPressed:(id)sender;

@end

@implementation HomeTableViewController

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
    // TODO: Return the number of classes the user is enrolled in.
    return 1;
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

#pragma mark - User Interaction

- (IBAction)menuButtonPressed:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.sideMenuViewController presentLeftMenuViewController];
}

- (IBAction)newButtonPressed:(id)sender
{
    
}

@end
