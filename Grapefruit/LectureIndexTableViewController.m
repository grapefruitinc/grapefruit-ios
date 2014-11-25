//
//  CapsuleLectureIndexTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 11/25/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "LectureIndexTableViewController.h"
#import "ApiManager.h"
#import "LectureInformationTableViewController.h"

@interface LectureIndexTableViewController ()

- (IBAction)backButtonPressed:(id)sender;

@property (strong, nonatomic) ApiManager *sharedApiManager;
@property (strong, nonatomic) NSDictionary *capsuleInformation;

@end

@implementation LectureIndexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.capsuleInformation = [NSDictionary new];
    
    self.sharedApiManager = [ApiManager sharedInstance];
    self.sharedApiManager.delegate = self;
    [self.sharedApiManager getCapsuleInformation:self.courseID capsule:self.capsuleID];
}

#pragma mark - ApiManager Delegate

- (void)getCapsuleInformationSuccessful:(NSDictionary *)capsuleInformation
{
    self.capsuleInformation = self.capsuleInformation;
    //    [self.tableView reloadData];
}

- (void)getCapsuleInformationFailedWithError:(NSError *)error
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

#pragma mark - User Interaction

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

