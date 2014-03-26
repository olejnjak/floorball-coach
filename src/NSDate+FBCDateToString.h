//
//  NSDate+FBCDateToString.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FBCDateToString)

- (NSString*)localString;

- (NSString*)dateToString;
+ (NSDate*)dateFromString:(NSString*)string;

@end
