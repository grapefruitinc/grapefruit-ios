//
//  CapsuleTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 12/2/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "CapsuleTableViewController.h"
#import "ApiManager.h"

@interface CapsuleTableViewController () <ApiManagerDelegate>

@property (strong, nonatomic) ApiManager *apiManager;

@end

@implementation CapsuleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.title = self.capsuleInformation[@"name"];
    
    self.apiManager = [ApiManager sharedInstance];
    self.apiManager.delegate = self;
    [self.apiManager getCapsuleInformation:self.courseID capsule:self.capsuleID];
    self.tableView.userInteractionEnabled = NO;
    
    // TODO: Display loading spinner.
}

#pragma mark - ApiManager Delegate

- (void)getCapsuleInformationSuccessful:(NSDictionary *)capsuleInformation
{
    self.capsuleInformation = capsuleInformation;
    self.tableView.userInteractionEnabled = YES;
    
    // TODO: Dismiss loading spinner.
}

- (void)getCapsuleInformationFailedWithError:(NSError *)error
{
    NSLog(@"%@", error.localizedDescription);
}

@end
