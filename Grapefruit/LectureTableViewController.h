//
//  LectureTableViewController.h
//  Grapefruit
//
//  Created by Logan Shire on 11/25/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LectureTableViewController : UITableViewController

@property (nonatomic) NSInteger courseID;
@property (nonatomic) NSInteger capsuleID;
@property (nonatomic) NSInteger lectureID;
@property (strong, nonatomic) NSDictionary *lectureInformation;

@end
