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
NSString * const GrapefruitErrorDomain = @"Grapefruit";

@interface ApiManager () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSUserDefaults *userDefaults;
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
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        if ([self.userDefaults valueForKey:@"user_id"])
        {
            self.userID = [[self.userDefaults valueForKey:@"user_id"] integerValue];
            self.email = [self.userDefaults valueForKey:@"user_email"];
            self.name = [self.userDefaults valueForKey:@"user_name"];
            self.authenticationToken = [self.userDefaults valueForKey:@"authentication_token"];
        }
        self.mutableData = [NSMutableData new];
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

#pragma mark - Helper Methods

- (NSURLRequest *)requestWithURL:(NSURL *)requestURL method:(NSString *)requestMethod header:(NSDictionary *)headerDictionary body:(NSDictionary *)bodyDictionary
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
    [request setHTTPMethod:requestMethod];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    if (headerDictionary)
    {
        for (NSString *key in headerDictionary.allKeys)
        {
            [request addValue:headerDictionary[key] forHTTPHeaderField:key];
        }
    }
    if (bodyDictionary)
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyDictionary options:0 error:nil];
        [request setHTTPBody:jsonData];
    }
    return [request copy];
}

#pragma mark - Public Methods

// Account

- (void)signUpWithEmail:(NSString *)email password:(NSString *)password name:(NSString *)name
{
    self.apiCall = @"sign_up";
    NSURL *signUpUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", BASE_URL, @"sign_up"]];
    NSDictionary *bodyDictionary = @{@"user":@{@"email":email, @"password":password,@"name":name}};
    NSURLRequest *request = [self requestWithURL:signUpUrl method:@"POST" header:nil body:bodyDictionary];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)signInWithEmail:(NSString *)email password:(NSString *)password
{
    self.apiCall = @"sign_in";
    NSURL *signInUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", BASE_URL, @"sign_in"]];
    NSDictionary *bodyDictionary = @{@"user":@{@"email":email, @"password":password}};
    NSURLRequest *request = [self requestWithURL:signInUrl method:@"POST" header:nil body:bodyDictionary];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)editAccount:(NSString *)email password:(NSString *)password name:(NSString *)name
{
    self.apiCall = @"edit_account";
    NSURL *editAccountUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", BASE_URL, @"edit_account"]];
    NSDictionary *headerDictionary = @{@"user-email":self.email, @"authentication-token":self.authenticationToken};
    NSMutableDictionary *userDictionary = [NSMutableDictionary new];
    if (email) {
        userDictionary[@"email"] = email;
    }
    if (password) {
        userDictionary[@"password"] = password;
    }
    if (name) {
        userDictionary[@"name"] = name;
    }
    NSDictionary *bodyDictionary = @{@"user":[userDictionary copy]};
    NSURLRequest *request = [self requestWithURL:editAccountUrl method:@"PUT" header:headerDictionary body:bodyDictionary];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)signOut
{
    self.apiCall = @"sign_out";
    NSURL *signOutUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", BASE_URL, @"sign_out"]];
    NSDictionary *headerDictionary = @{@"user-email":self.email, @"authentication-token":self.authenticationToken};
    NSURLRequest *request = [self requestWithURL:signOutUrl method:@"DELETE" header:headerDictionary body:nil];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

// Courses

- (void)getCourseIndex
{
    self.apiCall = @"course_index";
    NSURL *courseIndexUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", BASE_URL, @"courses"]];
    NSDictionary *headerDictionary = @{@"user-email":self.email, @"authentication-token":self.authenticationToken};
    NSURLRequest *request = [self requestWithURL:courseIndexUrl method:@"GET" header:headerDictionary body:nil];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)getCourseInformation:(NSInteger)courseID
{
    self.apiCall = @"course_information";
    NSURL *courseInformationUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/courses/%ld", BASE_URL, (long)courseID]];
    NSDictionary *headerDictionary = @{@"user-email":self.email, @"authentication-token":self.authenticationToken};
    NSURLRequest *request = [self requestWithURL:courseInformationUrl method:@"GET" header:headerDictionary body:nil];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)getCapsuleIndex:(NSInteger)courseID
{
    self.apiCall = @"capsule_index";
    NSURL *capsuleIndexUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/courses/%ld/capsules", BASE_URL, (long)courseID]];
    NSDictionary *headerDictionary = @{@"user-email":self.email, @"authentication-token":self.authenticationToken};
    NSURLRequest *request = [self requestWithURL:capsuleIndexUrl method:@"GET" header:headerDictionary body:nil];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)getCapsuleInformation:(NSInteger)courseID capsule:(NSInteger)capsuleID
{
    self.apiCall = @"capsule_information";
    NSURL *capsuleInformationUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/courses/%ld/capsules/%ld", BASE_URL, (long)courseID, (long)capsuleID]];
    NSDictionary *headerDictionary = @{@"user-email":self.email, @"authentication-token":self.authenticationToken};
    NSURLRequest *request = [self requestWithURL:capsuleInformationUrl method:@"GET" header:headerDictionary body:nil];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)getLectureInformation:(NSInteger)courseID capsule:(NSInteger)capsuleID lecture:(NSInteger)lectureID
{
    self.apiCall = @"lecture_information";
    NSURL *capsuleInformationUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%s/courses/%ld/capsules/%ld/lectures/%ld", BASE_URL, (long)courseID, (long)capsuleID, (long)lectureID]];
    NSDictionary *headerDictionary = @{@"user-email":self.email, @"authentication-token":self.authenticationToken};
    NSURLRequest *request = [self requestWithURL:capsuleInformationUrl method:@"GET" header:headerDictionary body:nil];
    [NSURLConnection connectionWithRequest:request delegate:self];
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
    else if ([self.apiCall isEqualToString:@"edit_account"])
    {
        [self.delegate editAccountFailedWithError:error];
    }
    else if ([self.apiCall isEqualToString:@"sign_out"])
    {
        [self.delegate signOutFailedWithError:error];
    }
    else if ([self.apiCall isEqualToString:@"course_index"])
    {
        [self.delegate getCourseIndexFailedWithError:error];
    }
    else if ([self.apiCall isEqualToString:@"course_information"])
    {
        [self.delegate getCourseIndexFailedWithError:error];
    }
    else if ([self.apiCall isEqualToString:@"capsule_index"])
    {
        [self.delegate getCapsuleIndexFailedWithError:error];
    }
    else if ([self.apiCall isEqualToString:@"capsule_information"])
    {
        [self.delegate getCapsuleInformationFailedWithError:error];
    }
    else if ([self.apiCall isEqualToString:@"lecture_information"])
    {
        [self.delegate getLectureInformationFailedWithError:error];
    }
    self.mutableData = [NSMutableData new];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.mutableData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // TEST:
//    NSString *dataString = [[NSString alloc] initWithData:[self.mutableData copy] encoding:NSStringEncodingConversionAllowLossy];
//    NSLog(@"%@", dataString);
    
    NSObject *response = [NSJSONSerialization JSONObjectWithData:[self.mutableData copy] options:NSJSONReadingAllowFragments error:nil];
    
    // Check for error:
    if ([response isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *responseDictionary = ((NSDictionary *)response);
        if (responseDictionary[@"success"] && ![responseDictionary[@"success"] boolValue])
        {
            NSError *error = [self errorWithMessage:responseDictionary[@"message"]];
            if ([self.apiCall isEqualToString:@"sign_up"])
            {
                [self.delegate signUpFailedWithError:error];
            }
            else if ([self.apiCall isEqualToString:@"sign_in"])
            {
                [self.delegate signInFailedWithError:error];
            }
            else if ([self.apiCall isEqualToString:@"edit_account"])
            {
                [self.delegate editAccountFailedWithError:error];
            }
            else if ([self.apiCall isEqualToString:@"sign_out"])
            {
                [self.delegate signOutFailedWithError:error];
            }
            else if ([self.apiCall isEqualToString:@"course_index"])
            {
                [self.delegate getCourseIndexFailedWithError:error];
            }
            else if ([self.apiCall isEqualToString:@"course_information"])
            {
                [self.delegate getCourseInformationFailedWithError:error];
            }
            else if ([self.apiCall isEqualToString:@"capsule_index"])
            {
                [self.delegate getCapsuleIndexFailedWithError:error];
            }
            else if ([self.apiCall isEqualToString:@"capsule_information"])
            {
                [self.delegate getCapsuleInformationFailedWithError:error];
            }
            else if ([self.apiCall isEqualToString:@"lecture_information"])
            {
                [self.delegate getLectureInformationFailedWithError:error];
            }
            return;
        }
    }
    
    
    // Perform requisite actions:
    if ([self.apiCall isEqualToString:@"sign_up"])
    {
        NSDictionary *responseDictionary = ((NSDictionary *)response);
        self.userID = [responseDictionary[@"id"] integerValue];
        self.email = responseDictionary[@"email"];
        self.name = responseDictionary[@"name"];
        self.authenticationToken = responseDictionary[@"authentication_token"];
        [self save];
        [self.delegate signUpSuccessful];
    }
    else if ([self.apiCall isEqualToString:@"sign_in"])
    {
        NSDictionary *responseDictionary = ((NSDictionary *)response);
        self.userID = [responseDictionary[@"id"] integerValue];
        self.email = responseDictionary[@"email"];
        self.name = responseDictionary[@"name"];
        self.authenticationToken = responseDictionary[@"authentication_token"];
        [self save];
        [self.delegate signInSuccessful];
    }
    else if ([self.apiCall isEqualToString:@"edit_account"])
    {
        NSDictionary *responseDictionary = ((NSDictionary *)response);
        self.userID = [responseDictionary[@"id"] integerValue];
        self.email = responseDictionary[@"email"];
        self.name = responseDictionary[@"name"];
        self.authenticationToken = responseDictionary[@"authentication_token"];
        [self save];
        [self.delegate editAccountSuccessful];
    }
    else if ([self.apiCall isEqualToString:@"sign_out"])
    {
        [self.userDefaults removeObjectForKey:@"user_id"];
        [self.userDefaults removeObjectForKey:@"email"];
        [self.userDefaults removeObjectForKey:@"name"];
        [self.userDefaults removeObjectForKey:@"authentication_token"];
        [self.userDefaults synchronize];
        [self.delegate signOutSuccessful];
    }
    else if ([self.apiCall isEqualToString:@"course_index"])
    {
        NSArray *responseArray = ((NSArray *)response);
        [self.delegate getCourseIndexSuccessful:responseArray];
    }
    else if ([self.apiCall isEqualToString:@"course_information"])
    {
        NSDictionary *responseDictionary = ((NSDictionary *)response);
        [self.delegate getCourseInformationSuccessful:responseDictionary];
    }
    else if ([self.apiCall isEqualToString:@"capsule_index"])
    {
        NSArray *responseArray = ((NSArray *)response);
        [self.delegate getCapsuleIndexSuccessful:responseArray];
    }
    else if ([self.apiCall isEqualToString:@"capsule_information"])
    {
        NSDictionary *responseDictionary = ((NSDictionary *)response);
        [self.delegate getCapsuleInformationSuccessful:responseDictionary];
    }
    else if ([self.apiCall isEqualToString:@"lecture_information"])
    {
        NSDictionary *responseDictionary = ((NSDictionary *)response);
        [self.delegate getLectureInformationSuccessful:responseDictionary];
    }
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
