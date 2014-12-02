//
//  LectureDocumentsTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 12/2/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "LectureDocumentsTableViewController.h"

@interface LectureDocumentsTableViewController ()

- (IBAction)backButtonpressed:(id)sender;

@end

@implementation LectureDocumentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (IBAction)backButtonpressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
