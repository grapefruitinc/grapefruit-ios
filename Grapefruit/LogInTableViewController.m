//
//  LogInTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 9/15/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "LogInTableViewController.h"
#import "HomeTableViewController.h"

@interface LogInTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LogInTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, -1, self.tableView.frame.size.width, 1)];
    self.tableView.tableHeaderView.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.emailTextField.delegate =
    self.passwordTextField.delegate = self;
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSArray *textFields =
    @[self.emailTextField,
      self.passwordTextField];
    
    // Check if all fields are filled. If so, create account.
    BOOL allTextFieldsFilled = YES;
    for (unsigned i = 0; i < textFields.count; i++)
    {
        if ([[textFields[i] text] isEqualToString:@""])
        {
            allTextFieldsFilled = NO;
            if (![textField isEqual:textFields[i]])
            {
                [textField resignFirstResponder];
                [textFields[i] becomeFirstResponder];
            }
            break;
        }
    }
    if (allTextFieldsFilled)
    {
        // TODO: Log in.
    }
    
    return NO;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row)
    {
        case 0:
        {
            [self.emailTextField becomeFirstResponder];
            break;
        }
        case 1:
        {
            [self.passwordTextField becomeFirstResponder];
            break;
        }
        case 2:
        {
            // TODO: Log the user in.
            HomeTableViewController *homeTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeTableViewController"];
            [self.navigationController pushViewController:homeTableViewController animated:YES];
            break;
        }
        case 3:
        {
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
    }
}

@end
