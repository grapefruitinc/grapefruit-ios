//
//  CourseAnnouncementsTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 12/2/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "CourseAnnouncementsTableViewController.h"
#import "AnnouncementTableViewCell.h"

@interface CourseAnnouncementsTableViewController ()

- (IBAction)backButtonPressed:(id)sender;

@end

@implementation CourseAnnouncementsTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courseAnnouncements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AnnouncementCell";
    AnnouncementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.announcementLabel.text = self.courseAnnouncements[indexPath.row];
    
    return cell;
}

- (IBAction)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
