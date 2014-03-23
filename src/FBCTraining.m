//
//  FBCTraining.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCTraining.h"
#import "FBCExercise.h"
#import "FBCTrainingUnitLibrary.h"

@implementation FBCTraining
{
    dispatch_once_t _onceToken;
    
    NSMutableArray *_mutableExercises;
}

@synthesize date = _date;
@synthesize name = _name;

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
        if ([name length] < 1)
        {
            return nil;
        }
        
        [self __setInitState];
        
        _date = [NSDate date];
        [self setName:name];
    }
    
    return self;
}

- (void)__setInitState
{
    _mutableExercises = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Custom properties

- (NSMutableArray*)mutableExercises
{
    dispatch_once(&_onceToken, ^{
        _mutableExercises = [[NSMutableArray alloc] initWithCapacity:1];
    });
    
    return _mutableExercises;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCTrainingUnitProtocol methods

- (NSArray*)flatten
{
    // In theory it is possible to have a training as a subunit to another training thats why it is correct to iterate
    // over all subunits and ask them to flatten themselves. Practically when only simple exercises can stand
    // as a subunit it would be enough just to prepend self to exercises array and return it.
    
    NSMutableArray *mutableResult = [NSMutableArray arrayWithObject:self];
    
    for (id<FBCTrainingUnitProtocol> unit in self.exercises)
    {
        NSArray *flatUnit = [unit flatten];
        
        [mutableResult addObjectsFromArray:flatUnit];
    }
    
    NSArray *result = [NSArray arrayWithArray:mutableResult];
    
    return result;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public interface

- (NSArray*)exercises
{
    NSArray *result = [NSArray arrayWithArray:self.mutableExercises];

    return result;
}

- (void)addExercise:(FBCExercise *)exercise
{
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
    
    [self.mutableExercises addObject:exercise];
    [exercise setParent:self];
    [library addExercise:exercise];
}

- (void)addExercises:(NSArray *)exercises
{
    [exercises enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addExercise:obj];
    }];
}

- (void)removeExercise:(FBCExercise *)exercise
{
    [exercise setParent:nil];
    [self.mutableExercises removeObject:exercise];
}

@end
