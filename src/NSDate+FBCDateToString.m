//
//  NSDate+FBCDateToString.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "NSDate+FBCDateToString.h"

static NSString *kFBCDateFormat = @"yyyyMMddHH:mm";

@implementation NSDate (FBCDateToString)

- (NSString*)localString
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterNoStyle];
    
    return [df stringFromDate:self];
}

- (NSString*)dateToString
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];

    [df setDateFormat:kFBCDateFormat];
    
    return [df stringFromDate:self];
}

+ (NSDate*)dateFromString:(NSString *)string
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setDateFormat:kFBCDateFormat];
    
    return [df dateFromString:string];
}

@end
