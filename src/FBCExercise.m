//
//  FBCExercise.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCExercise.h"

@implementation FBCExercise

@synthesize name = _name;
@synthesize dateCreated = _dateCreated;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (id)init
{
    return nil;
}

- (id)initWithName:(NSString *)name
{
    self = [super init];
    
    if (self != nil)
    {
        if ([name length] == 0)
        {
            return nil;
        }
        
        [self setName:name];
        _dateCreated = [NSDate date];
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCTrainingUnitProtocol methods

- (NSUInteger)subunitsCount
{
    return 1;
}

- (NSArray*)flatten
{
    return @[self];
}

@end
