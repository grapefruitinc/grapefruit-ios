//
//  CapsuleTableViewController.h
//  Grapefruit
//
//  Created by Logan Shire on 12/2/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CapsuleTableViewController : UITableViewController

@property (nonatomic) NSInteger courseID;
@property (nonatomic) NSInteger capsuleID;
@property (strong, nonatomic) NSDictionary *capsuleInformation;

@end
