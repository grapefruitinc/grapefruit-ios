//
//  MenuTableViewController.m
//  Grapefruit
//
//  Created by Logan Shire on 12/1/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "MenuTableViewController.h"
#import "ApiManager.h"

@interface MenuTableViewController () <ApiManagerDelegate>

- (IBAction)closeButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ApiManager *sharedManager = [ApiManager sharedInstance];
    sharedManager.delegate = self;
    switch (indexPath.row) {
        case 4:
            // Do stuff to update account:
            if ([self isValid]) {
                
                NSString *newEmail = ([self.emailTextField.text isEqualToString:@""]) ? nil : self.emailTextField.text;
                NSString *newPassword = ([self.passwordTextField.text isEqualToString:@""]) ? nil : self.passwordTextField.text;
                NSString *newName = ([self.nameTextField.text isEqualToString:@""]) ? nil : self.nameTextField.text;
                [sharedManager editAccount:newEmail password:newPassword name:newName];
            }
            break;
        case 5:
        {
            // Log out the user:
            [sharedManager signOut];
            break;
        }
        default:
            break;
    }
}

#pragma mark - ApiManager Delegate

- (void)editAccountSuccessful
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                        message:@"Account informaiton updated successfully."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)editAccountFailedWithError:(NSError *)error
{
    NSLog(@"%@", error.localizedDescription);
}

- (void)signOutSuccessful
{
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
    [self.delegate popViewControllerAnimated:YES];
}

- (void)signOutFailedWithError:(NSError *)error
{
    NSLog(@"%@", error.localizedDescription);
}

#pragma mark - Helper Functions

- (BOOL)isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (BOOL)isValid
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    if (![self.emailTextField.text isEqualToString:@""] && ![self isValidEmail:self.emailTextField.text])
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
    if (![self.passwordTextField.text isEqualToString:self.confirmTextField.text])
    {
        alertView.message = @"The passwords must match.";
        [alertView show];
        return NO;
    }
    return YES;
}

#pragma mark - User Interaction

- (IBAction)closeButtonPressed:(id)sender {
    
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

@end
