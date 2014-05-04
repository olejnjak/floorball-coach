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

static NSString *kFBCNameKey = @"name";
static NSString *kFBCDateKey = @"date";
static NSString *kFBCExerciseKey = @"exercises";

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
#pragma mark - NSCoding methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (nil != self)
    {
        [self __setInitState];
        
        NSDate *date = [aDecoder decodeObjectForKey:kFBCDateKey];
        NSString *name = [aDecoder decodeObjectForKey:kFBCNameKey];
        NSMutableArray *exercises = [aDecoder decodeObjectForKey:kFBCExerciseKey];
        
        _date = date;
        [self setName:name];
        _mutableExercises = exercises;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.date forKey:kFBCDateKey];
    [aCoder encodeObject:self.name forKey:kFBCNameKey];
    [aCoder encodeObject:self.mutableExercises forKey:kFBCExerciseKey];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Custom properties

- (NSMutableArray*)mutableExercises
{
    dispatch_once(&_onceToken, ^{
        if (_mutableExercises == nil)
        {
            _mutableExercises = [[NSMutableArray alloc] initWithCapacity:1];
        }
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
    if (nil == exercise)
    {
        return;
    }
    
    FBCExercise *exerciseCopy = [exercise copy];
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
    
    [self.mutableExercises addObject:exerciseCopy];
    [exerciseCopy setParent:self];
    [library addExercise:exerciseCopy];
}

- (void)addExercise:(FBCExercise *)exercise toIndex:(NSInteger)index
{
    if (nil == exercise)
    {
        return;
    }

    FBCExercise *exerciseCopy = [exercise copy];
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
    
    [self.mutableExercises insertObject:exerciseCopy atIndex:index];
    [exerciseCopy setParent:self];
    [library addExercise:exerciseCopy];
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

- (void)moveExerciseFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    FBCExercise *exercise = [self.exercises objectAtIndex:fromIndex];
    
    [self.mutableExercises removeObjectAtIndex:fromIndex];
    [self.mutableExercises insertObject:exercise atIndex:toIndex];
}

@end
