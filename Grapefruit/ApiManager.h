//
//  ApiManager.h
//  Grapefruit
//
//  Created by Logan Shire on 10/13/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApiManagerDelegate <NSObject>

@optional
- (void)signUpSuccessful;
- (void)signUpFailedWithError:(NSError *)error;
- (void)signInSuccessful;
- (void)signInFailedWithError:(NSError *)error;
- (void)signOutSuccessful;
- (void)signOutFailedWithError:(NSError *)error;
- (void)getCourseIndexSuccessful:(NSArray *)courseIndex;
- (void)getCourseIndexFailedWithError:(NSError *)error;
- (void)getCourseInformationSuccessful:(NSDictionary *)courseInformation;
- (void)getCourseInformationFailedWithError:(NSError *)error;
- (void)getCapsuleIndexSuccessful:(NSArray *)capsuleIndex;
- (void)getCapsuleIndexFailedWithError:(NSError *)error;
- (void)getCapsuleInformationSuccessful:(NSDictionary *)capsuleInformation;
- (void)getCapsuleInformationFailedWithError:(NSError *)error;

@end

@interface ApiManager : NSObject

@property (strong, nonatomic) id delegate;

@property (nonatomic) NSUInteger userID;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *authenticationToken;

+ (instancetype)sharedInstance;
- (void)signUpWithEmail:(NSString *)email password:(NSString *)password name:(NSString *)name;
- (void)signInWithEmail:(NSString *)email password:(NSString *)password;
- (void)signOut;
- (void)getCourseIndex;
- (void)getCourseInformation:(NSInteger)courseID;
- (void)getCapsuleIndex:(NSInteger)courseID;
- (void)getCapsuleInformation:(NSInteger)courseID capsule:(NSInteger)capsuleID;

@end
