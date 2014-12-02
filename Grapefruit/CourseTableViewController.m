//
//  CourseTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 9/15/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "CourseTableViewController.h"
#import "ApiManager.h"
#import "CourseTableViewCell.h"

#import "CourseDescriptionViewController.h"
#import "CourseInstructorsTableViewController.h"
#import "CourseAnnouncementsTableViewController.h"
#import "CourseCapsulesTableViewController.h"

@interface CourseTableViewController() <ApiManagerDelegate>

- (IBAction)backButtonPressed:(id)sender;

@property (strong, nonatomic) ApiManager *sharedApiManager;

@end

@implementation CourseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.title = [NSString stringWithFormat:@"%@ %@", self.courseInformation[@"subject"], self.courseInformation[@"course_number"]];
    
    self.sharedApiManager = [ApiManager sharedInstance];
    self.sharedApiManager.delegate = self;
    
    // TODO: Display loading spinner.
    
    [self.sharedApiManager getCourseInformation:self.courseID];
    self.tableView.userInteractionEnabled = NO;
}

#pragma mark - ApiManager Delegate

- (void)getCourseInformationSuccessful:(NSDictionary *)courseInformation
{
    self.courseInformation = courseInformation;
    self.tableView.userInteractionEnabled = YES;
    
    // TODO: Dismiss loading spinner.
}

- (void)getCourseInformationFailedWithError:(NSError *)error
{
    NSLog(@"%@", error.localizedDescription);
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row)
    {
        case 0: // Description
        {
            CourseDescriptionViewController *courseDescriptionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseDescriptionViewController"];
            NSString *description = [self.courseInformation[@"description"] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            courseDescriptionViewController.courseDescription = description;
            [self.navigationController showViewController:courseDescriptionViewController sender:self];
            break;
        }
        case 1: // Instructors
            // TODO: Update this when a course has many instructors.
        {
            NSArray *instructors = [NSArray arrayWithObject:self.courseInformation[@"instructor"]];
            
            CourseInstructorsTableViewController *courseInstructorsTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseInstructorsTableViewController"];
            courseInstructorsTableViewController.courseInstructors = instructors;
            [self.navigationController showViewController:courseInstructorsTableViewController sender:self];
            break;
        }
        case 2: // Announcements
            if (((NSArray *)self.courseInformation[@"announcements"]).count > 0)
            {
                // TODO: show VC for announcements.
                CourseAnnouncementsTableViewController *courseAnnouncementsTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseCapsulesTableViewController"];
                courseAnnouncementsTableViewController.courseAnnouncements = self.courseInformation[@"announcements"];
                [self.navigationController showViewController:courseAnnouncementsTableViewController sender:self];
            }
            break;
        case 3: // Capsules
            if (((NSArray *)self.courseInformation[@"capsules"]).count > 0)
            {
                CourseCapsulesTableViewController *courseCapsulesTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseCapsulesTableViewController"];
                courseCapsulesTableViewController.courseID = self.courseID;
                courseCapsulesTableViewController.courseCapsules = self.courseInformation[@"capsules"];
                [self.navigationController showViewController:courseCapsulesTableViewController sender:self];
            }
        default:
            break;
    }
}

#pragma mark - User Interaction

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
