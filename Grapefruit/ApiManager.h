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
- (void)getCoursesSuccessful;
- (void)getCoursesFailedWithError:(NSError *)error;

@end

@interface ApiManager : NSObject

@property (strong, nonatomic) id delegate;
@property (nonatomic) NSUInteger userID;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *authenticationToken;
@property (strong, nonatomic) NSMutableDictionary *courses;

+ (instancetype)sharedInstance;
- (void)signUpWithEmail:(NSString *)email password:(NSString *)password name:(NSString *)name;
- (void)signInWithEmail:(NSString *)email password:(NSString *)password;
- (void)signOut;
- (void)getCourses;

@end
