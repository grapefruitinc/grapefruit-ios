//
//  CourseTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 9/15/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "CourseInformationTableViewController.h"
#import "ApiManager.h"
#import "CourseTableViewCell.h"
#import "CapsuleIndexTableViewController.h"

@interface CourseInformationTableViewController() <ApiManagerDelegate>

- (IBAction)backButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *courseDescriptionLabel;

@property (strong, nonatomic) NSDictionary *courseInformation;
@property (strong, nonatomic) NSArray *announcements;
@property (strong, nonatomic) NSArray *capsules;

@property (strong, nonatomic) ApiManager *sharedApiManager;

@end

@implementation CourseInformationTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sharedApiManager = [ApiManager sharedInstance];
    self.sharedApiManager.delegate = self;
    [self.sharedApiManager getCourseInformation:self.courseID];
}

#pragma mark - ApiManager Delegate

- (void)getCourseInformationSuccessful:(NSDictionary *)courseInformation
{
    NSLog(@"%@", courseInformation);
    self.courseInformation = courseInformation;
    
    // Title
    self.title = self.courseInformation[@"name"];
    
    // Description
    NSString *description = [self.courseInformation[@"description"] stringByReplacingOccurrencesOfString:@"\n" withString:@""];;
    CGSize size = CGSizeMake(self.courseDescriptionLabel.bounds.size.width, CGFLOAT_MAX);
    NSDictionary *attributes =
    @{
      NSFontAttributeName:[UIFont fontWithName:@"AvenirNext-Regular" size:16.0],
      NSForegroundColorAttributeName:[UIColor whiteColor],
      };
    CGRect descriptionLabelRect = [description boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.view.bounds.size.width, descriptionLabelRect.size.height + 16.0);
    self.courseDescriptionLabel.text = description;
    
    // Instructor
    CourseTableViewCell *cell = (CourseTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSDictionary *instructor = courseInformation[@"instructor"];
    cell.courseTitleLabel.text = instructor[@"name"];
    cell.courseNumberLabel.text = instructor[@"email"];
    
    // Announcements
    cell = (CourseTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    self.announcements = courseInformation[@"announcements"];
    cell.courseNumberLabel.text = [NSString stringWithFormat:@"%lu Announcements", self.announcements.count];
    
    // Capsules
    cell = (CourseTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    self.capsules = courseInformation[@"capsules"];
    cell.courseNumberLabel.text = [NSString stringWithFormat:@"%lu Capsules", self.capsules.count];
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
        case 0: // Instructor
            // TODO: Open an email
            break;
        case 1: // Announcements
            if (self.announcements.count > 0)
            {
                // TODO: show VC for announcements.
            }
            break;
        case 2: // Capsules
            if (self.capsules.count > 0)
            {
                CapsuleIndexTableViewController *capsuleIndexTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CapsuleIndexTableViewController"];
                capsuleIndexTableViewController.courseID = self.courseID;
                [self.navigationController showViewController:capsuleIndexTableViewController sender:self];
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
