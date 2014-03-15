//
//  FBCTrainingUnitLibrary.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCTrainingUnitLibrary.h"
#import "TestFBCTrainingUnitLibrary.h"
#import "FBCExercise.h"

static FBCTrainingUnitLibrary *g_Library = nil;

@implementation FBCTrainingUnitLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class methods

+ (FBCTrainingUnitLibrary*)library
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_Library = [[TestFBCTrainingUnitLibrary alloc] init];
    });
    
    return g_Library;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
        [self __setInitState];
        [self loadStructure];
    }
    
    return self;
}

- (void)__setInitState
{
    _units = [NSMutableArray arrayWithCapacity:1];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public interface

- (NSUInteger)count
{
    return [_units count];
}

- (NSArray*)units
{
    NSArray *units = [NSArray arrayWithArray:_units];

    return units;
}

- (NSArray*)flatUnits
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:1];
    
    for (id<FBCTrainingUnitProtocol> unit in _units)
    {
        NSArray *flatUnit = [unit flatten];
        
        [result addObjectsFromArray:flatUnit];
    }
    
    return result;
}

- (NSArray*)exercises
{
    NSMutableArray *mutableResult = [NSMutableArray arrayWithCapacity:1];
    
    for (id<FBCTrainingUnitProtocol> unit in _units)
    {
        if ([unit isKindOfClass:[FBCExercise class]])
        {
            [mutableResult addObject:unit];
        }
    }
    
    NSArray *result = [NSArray arrayWithArray:mutableResult];
    
    return result;
}

- (void)addUnit:(id<FBCTrainingUnitProtocol>)unit
{
    [_units addObject:unit];
}

- (void)removeUnit:(id<FBCTrainingUnitProtocol>)unit
{
    [_units removeObject:unit];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Serialization

- (void)saveStructure
{
    
}

- (void)loadStructure
{
    
}

@end
