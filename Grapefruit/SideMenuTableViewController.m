//
//  SideMenuTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 9/15/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "SideMenuTableViewController.h"
#import "RESideMenu.h"

@interface SideMenuTableViewController ()

@property (strong, nonatomic) NSArray *menuItems;

@end

@implementation SideMenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menuItems = @[@"Home", @"Courses", @"Profile", @"Help", @"Log Out"];
}

#pragma mark - TableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:24.0f];
        cell.textLabel.textColor = [UIColor whiteColor];
        [[cell contentView] setBackgroundColor:[UIColor clearColor]];
        [[cell backgroundView] setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (self.tableView.frame.size.height - 64*self.menuItems.count)/2.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (self.tableView.frame.size.height - 64*self.menuItems.count)/2.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RESideMenu *sideMenuViewController = [[[UIApplication sharedApplication] delegate] presentLeftMenuViewController];
    
    switch (indexPath.row)
    {
        case 0:
        {
            // Home
            break;
        }
            case 1:
        {
            // Courses
            break;
        }
            case 2:
        {
            // Profile
            break;
        }
            case 3:
        {
            // Help
            break;
        }
            case 4:
        {
            // TODO: Log Out
            sideMenuTableViewController.SideMenuTableViewController
            break;
        }
        default:
        {
            break;
        }
    }
}

@end
