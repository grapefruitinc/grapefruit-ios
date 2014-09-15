//
//  SignUpTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 9/15/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "SignUpTableViewController.h"
#import "LogInTableViewController.h"
#import "HomeTableViewController.h"

@interface SignUpTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@end

@implementation SignUpTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, -1, self.tableView.frame.size.width, 1)];
    self.tableView.tableHeaderView.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.nameTextField.delegate =
    self.emailTextField.delegate =
    self.passwordTextField.delegate =
    self.confirmPasswordTextField.delegate = self;
    [self.nameTextField becomeFirstResponder];
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSArray *textFields =
  @[self.nameTextField,
    self.emailTextField,
    self.passwordTextField,
    self.confirmPasswordTextField];
    
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
        // TODO: Create account.
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
            [self.nameTextField becomeFirstResponder];
            break;
        }
        case 1:
        {
            [self.emailTextField becomeFirstResponder];
            break;
        }
        case 2:
        {
            [self.passwordTextField becomeFirstResponder];
            break;
        }
        case 3:
        {
            [self.confirmPasswordTextField becomeFirstResponder];
            break;
        }
        case 4:
        {
            // TODO: Create Account
            HomeTableViewController *homeTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeTableViewController"];
            [self.navigationController pushViewController:homeTableViewController animated:YES];
            break;
        }
        case 5:
        {
            LogInTableViewController *logInTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInTableViewController"];
            [self.navigationController pushViewController:logInTableViewController animated:YES];
            break;
        }
    }
}

@end
