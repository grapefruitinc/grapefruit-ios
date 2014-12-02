//
//  LectureVideosTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 12/2/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "LectureVideosTableViewController.h"

@interface LectureVideosTableViewController ()

- (IBAction)backButtonPressed:(id)sender;

@end

@implementation LectureVideosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
