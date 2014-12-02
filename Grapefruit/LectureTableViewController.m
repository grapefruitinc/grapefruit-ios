//
//  LectureTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 11/25/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "LectureTableViewController.h"
#import "ApiManager.h"

#import "LectureCommentsTableViewController.h"
#import "LectureDocumentsTableViewController.h"
#import "LectureVideosTableViewController.h"

@interface LectureTableViewController () <ApiManagerDelegate>

- (IBAction)backButtonPressed:(id)sender;

@property (strong, nonatomic) ApiManager *apiManager;

@end

@implementation LectureTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.lectureInformation = [NSDictionary new];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.apiManager = [ApiManager sharedInstance];
    self.apiManager.delegate = self;
    
    // TODO: Display loading spinner:
    
    [self.apiManager getLectureInformation:self.courseID capsule:self.capsuleID lecture:self.lectureID];
    self.tableView.userInteractionEnabled = NO;
}

#pragma mark - ApiManager Delegate

- (void)getLectureInformationSuccessful:(NSDictionary *)lectureInformation
{
    NSLog(@"%@", lectureInformation);
    self.lectureInformation = lectureInformation;
    self.tableView.userInteractionEnabled = YES;
    
    // TODO: Dismiss loading spinner:
}

- (void)getLectureInformationFailedWithError:(NSError *)error
{
    NSLog(@"%@", error.localizedDescription);
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            // Description
            break;
        case 1:
        {
            // Comments
            LectureCommentsTableViewController *lectureCommentsTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LectureCommentsTableViewController"];
            [self.navigationController showViewController:lectureCommentsTableViewController sender:self];
            break;
        }
        case 2:
        {
            // Documents
            LectureDocumentsTableViewController *lectureDocumentsTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LectureDocumentsTableViewController"];
            [self.navigationController showViewController:lectureDocumentsTableViewController sender:self];
            break;
        }
        case 3:
        {
            // Videos
            LectureVideosTableViewController *lectureVideosTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LectureVideosTableViewController"];
            [self.navigationController showViewController:lectureVideosTableViewController sender:self];
            break;
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

