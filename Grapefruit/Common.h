//
//  Common.h
//  Grapefruit
//
//  Created by Logan Shire on 10/17/14.
//  Copyright (c) 2014 Logan Shire. All rights reserved.
//

#include <Foundation/NSObject.h>

#ifndef COMMON_MACROS
#define COMMON_MACROS

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif