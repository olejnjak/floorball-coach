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
#import "FBCTraining.h"

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
    _trainings = [NSMutableArray arrayWithCapacity:1];
    _allExercises = [NSMutableArray arrayWithCapacity:1];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public interface

- (NSArray*)exercises
{
    NSArray *result = [_allExercises arrayByRemovingDuplicates];
    
    return result;
}

- (NSArray*)favoriteExercises
{
    NSArray *exercises = [self exercises];
    NSPredicate *favoritePredicate = [NSPredicate predicateWithFormat:@"favorite == YES"];
    NSArray *result = [exercises filteredArrayUsingPredicate:favoritePredicate];
    
    return result;
}

- (NSArray*)trainings
{
    NSArray *result = [NSArray arrayWithArray:_trainings];
    
    return result;
}

- (NSArray*)flatTrainings
{
    NSArray *trainings = _trainings;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:trainings.count];
    
    [trainings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FBCTraining *training = obj;
        NSArray *flatTraining = [training flatten];
        
        [result addObjectsFromArray:flatTraining];
    }];
    
    return result;
}

- (void)addExercise:(FBCExercise *)exercise
{
    [_allExercises addObject:exercise];
}

- (void)addTraining:(FBCTraining *)training
{
    [_trainings addObject:training];
}

- (void)removeTraining:(FBCTraining *)training
{
    [_trainings removeObject:training];
}

- (void)removeExercise:(FBCExercise *)exercise
{
    [_allExercises removeObject:exercise];
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
