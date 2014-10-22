//
//  ApiManager.m
//  Grapefruit
//
//  Created by Logan Shire on 10/13/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import "ApiManager.h"
#import "Common.h"

#define BASE_URL "http://localhost:3000/api/v1"

@interface ApiManager () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (strong, nonatomic) NSMutableURLRequest *request;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSString *apiCall;
@property (strong, nonatomic) NSMutableData *mutableData;

@end

@implementation ApiManager

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.courses = [NSMutableDictionary new];
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        if ([self.userDefaults valueForKey:@"user_id"])
        {
            self.userID = [[self.userDefaults valueForKey:@"user_id"] integerValue];
            self.email = [self.userDefaults valueForKey:@"user_email"];
            self.name = [self.userDefaults valueForKey:@"user_name"];
            self.authenticationToken = [self.userDefaults valueForKey:@"authentication_token"];
        }
        self.request = [NSMutableURLRequest new];
        self.mutableData = [NSMutableData new];
        [self.request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    return self;
}

+ (id)sharedInstance
{
    static dispatch_once_t onceToken = 0;
    static ApiManager *sharedObject = nil;
    dispatch_once(&onceToken,
                  ^{
                      sharedObject = [ApiManager new];
                  });
    
    return sharedObject;
}

#pragma mark - Public Methods

- (void)signUpWithEmail:(NSString *)email password:(NSString *)password name:(NSString *)name
{
    NSURL *signUpUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", BASE_URL, @"sign_up"]];
    [self.request setURL:signUpUrl];
    [self.request setHTTPMethod:@"POST"];
    NSDictionary *userDictionary = @{@"email":email, @"password":password,@"name":name};
    NSDictionary *postDictionary = @{@"user":userDictionary};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDictionary options:NSJSONWritingPrettyPrinted error:nil];
    [self.request setHTTPBody:jsonData];
    self.apiCall = @"sign_up";
    self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
}

- (void)signInWithEmail:(NSString *)email password:(NSString *)password
{
    NSURL *signInUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", BASE_URL, @"sign_in"]];
    [self.request setURL:signInUrl];
    [self.request setHTTPMethod:@"POST"];
    NSDictionary *userDictionary = @{@"email":email, @"password":password};
    NSDictionary *postDictionary = @{@"user":userDictionary};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDictionary options:NSJSONWritingPrettyPrinted error:nil];
    [self.request setHTTPBody:jsonData];
    self.apiCall = @"sign_in";
    self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
}

- (void)signOut
{
    NSURL *signOutUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", BASE_URL, @"sign_out"]];
    [self.request setURL:signOutUrl];
    [self.request setHTTPMethod:@"DELETE"];
    NSDictionary *userDictionary = @{@"email":self.email, @"token":self.authenticationToken};
    NSDictionary *postDictionary = @{@"authentication":userDictionary};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDictionary options:NSJSONWritingPrettyPrinted error:nil];
    [self.request setHTTPBody:jsonData];
    self.apiCall = @"sign_out";
    self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
}

- (void)getCourses
{
    NSURL *coursesUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", BASE_URL, @"courses"]];
    [self.request setURL:coursesUrl];
    [self.request setHTTPMethod:@"GET"];
    NSDictionary *userDictionary = @{@"email":self.email, @"token":self.authenticationToken};
    NSDictionary *postDictionary = @{@"authentication":userDictionary};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSStringEncodingConversionAllowLossy];
    NSLog(@"%@", string);
    [self.request setHTTPBody:jsonData];
    self.apiCall = @"courses";
    self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
}

#pragma mark - Connection Delegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([self.apiCall isEqualToString:@"sign_up"])
    {
        [self.delegate signUpFailedWithError:error];
    }
    else if ([self.apiCall isEqualToString:@"sign_in"])
    {
        [self.delegate signInFailedWithError:error];
    }
    else if ([self.apiCall isEqualToString:@"sign_out"])
    {
        [self.delegate signOutFailedWithError:error];
    }
    else if ([self.apiCall isEqualToString:@"courses"])
    {
        [self.delegate getCoursesFailedWithError:error];
    }
    self.request = [NSMutableURLRequest new];
    self.mutableData = [NSMutableData new];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%@", response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.mutableData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *dataString = [[NSString alloc] initWithData:[self.mutableData copy] encoding:NSStringEncodingConversionAllowLossy];
    NSLog(@"%@", dataString);
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:[self.mutableData copy] options:NSJSONReadingAllowFragments error:nil];
    if ([self.apiCall isEqualToString:@"sign_up"])
    {
        if (responseDictionary[@"success"] && ![responseDictionary[@"success"] boolValue])
        {
            [self.delegate signUpFailedWithError:[self errorWithMessage:responseDictionary[@"message"]]];
        }
        else
        {
            self.userID = [responseDictionary[@"id"] integerValue];
            self.email = responseDictionary[@"email"];
            self.name = responseDictionary[@"name"];
            self.authenticationToken = responseDictionary[@"authentication_token"];
            [self save];
            [self.delegate signUpSuccessful];
        }
    }
    else if ([self.apiCall isEqualToString:@"sign_in"])
    {
        if (responseDictionary[@"success"] && ![responseDictionary[@"success"] boolValue])
        {
            [self.delegate signInFailedWithError:[self errorWithMessage:responseDictionary[@"message"]]];
        }
        else
        {
            self.userID = [responseDictionary[@"id"] integerValue];
            self.email = responseDictionary[@"email"];
            self.name = responseDictionary[@"name"];
            self.authenticationToken = responseDictionary[@"authentication_token"];
            [self save];
            [self.delegate signInSuccessful];
        }
    }
    else if ([self.apiCall isEqualToString:@"sign_out"])
    {
        if (responseDictionary[@"success"] && ![responseDictionary[@"success"] boolValue])
        {
            [self.delegate signOutFailedWithError:[self errorWithMessage:responseDictionary[@"message"]]];
        }
        else
        {
            [self.userDefaults removeObjectForKey:@"user_id"];
            [self.userDefaults removeObjectForKey:@"email"];
            [self.userDefaults removeObjectForKey:@"name"];
            [self.userDefaults removeObjectForKey:@"authentication_token"];
            [self.userDefaults synchronize];
            [self.delegate signOutSuccessful];
        }
    }
    else if ([self.apiCall isEqualToString:@"courses"])
    {
        if (responseDictionary[@"success"] && ![responseDictionary[@"success"] boolValue])
        {
            [self.delegate getCoursesFailedWithError:[self errorWithMessage:responseDictionary[@"message"]]];
        }
        else
        {
            NSLog(@"%@", responseDictionary);
            [self.delegate getCoursesSuccessful];
        }
    }
    self.request = [NSMutableURLRequest new];
    self.mutableData = [NSMutableData new];
}

- (void)save
{
    [self.userDefaults setObject:@(self.userID) forKey:@"user_id"];
    [self.userDefaults setObject:self.email forKey:@"user_email"];
    [self.userDefaults setObject:self.name forKey:@"user_name"];
    [self.userDefaults setObject:self.authenticationToken forKey:@"authentication_token"];
    [self.userDefaults synchronize];
}

#pragma mark - Helper Functions

- (NSError *)errorWithMessage:(NSString *)message
{
    NSDictionary *userInfo =
    @{
      NSLocalizedDescriptionKey: NSLocalizedString(message, nil),
      };
    return [NSError errorWithDomain:GrapefruitErrorDomain
                                         code:-57
                                     userInfo:userInfo];
}

@end
