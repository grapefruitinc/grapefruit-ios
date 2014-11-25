//
//  SignUpTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 9/15/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "SignUpTableViewController.h"
#import "SignInTableViewController.h"
#import "CourseIndexTableViewController.h"
#import "ApiManager.h"

@interface SignUpTableViewController () <UITextFieldDelegate, ApiManagerDelegate>

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
    
    ApiManager *sharedApiManager = [ApiManager sharedInstance];
    if (sharedApiManager.userID)
    {
        CourseIndexTableViewController *courseIndexTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseIndexTableViewController"];
        [self.navigationController showViewController:courseIndexTableViewController sender:self];
    }
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
            // TODO: Validate Fields
            if ([self isValid])
            {
                ApiManager *sharedApiManager = [ApiManager sharedInstance];
                sharedApiManager.delegate = self;
                [sharedApiManager signUpWithEmail:self.emailTextField.text password:self.passwordTextField.text name:self.nameTextField.text];
            }
            break;
        }
        case 5:
        {
            SignInTableViewController *logInTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInTableViewController"];
            [self.navigationController showViewController:logInTableViewController sender:self];
            break;
        }
    }
}

#pragma mark - ApiManager Delegate

- (void)signUpSuccessful
{
    CourseIndexTableViewController *courseIndexTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseIndexTableViewController"];
    [self.navigationController showViewController:courseIndexTableViewController sender:self];
}

- (void)signUpFailedWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Helper Functions

- (BOOL)isValid
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    if ([self.nameTextField.text isEqualToString:@""])
    {
        alertView.message = @"Please enter your name.";
        [alertView show];
        return NO;
    }
    if ([self.emailTextField.text isEqualToString:@""])
    {
        alertView.message = @"Please enter your email address.";
        [alertView show];
        return NO;
    }
    if (![self isValidEmail:self.emailTextField.text])
    {
        alertView.message = @"Please enter a valid email address.";
        [alertView show];
        return NO;
    }
    if (self.passwordTextField.text.length < 8)
    {
        alertView.message = @"Your password must be at least 8 characters.";
        [alertView show];
        return NO;
    }
    if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text])
    {
        alertView.message = @"The passwords must match.";
        [alertView show];
        return NO;
    }
    return YES;
}

- (BOOL)isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
