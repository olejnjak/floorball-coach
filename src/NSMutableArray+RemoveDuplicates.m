//
//  NSMutableArray+RemoveDuplicates.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 23/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "NSMutableArray+RemoveDuplicates.h"

@implementation NSMutableArray (RemoveDuplicates)

- (NSArray*)arrayByRemovingDuplicates
{
    // Code of this method inspired by code available at
    // http://stackoverflow.com/questions/1025674/the-best-way-to-remove-duplicate-values-from-nsmutablearray-in-objective-c
    // Quoted 23 March 2014
    
    NSArray *copy = [self copy];
    NSInteger index = [copy count] - 1;
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (id object in [copy reverseObjectEnumerator])
    {
        if ([self indexOfObject:object inRange:NSMakeRange(0, index)] == NSNotFound)
        {
            [result addObject:object];
        }
    
        index--;
    }
    
    return [NSArray arrayWithArray:result];
}

@end
