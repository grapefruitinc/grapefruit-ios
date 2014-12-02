//
//  CourseDescriptionViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 12/2/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "CourseDescriptionViewController.h"

@interface CourseDescriptionViewController ()

- (IBAction)backButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *courseDescriptionTextView;

@end

@implementation CourseDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.courseDescriptionTextView.text = self.courseDescription;
}

- (IBAction)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
