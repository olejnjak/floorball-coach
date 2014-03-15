//
//  NSDate+FBCDateToString.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "NSDate+FBCDateToString.h"

@implementation NSDate (FBCDateToString)

- (NSString*)localString
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setDateStyle:NSDateFormatterShortStyle];
    [df setTimeStyle:NSDateFormatterNoStyle];
    
    return [df stringFromDate:self];
}

@end
