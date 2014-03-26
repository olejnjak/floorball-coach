//
//  FBCTrainingUnitLibrary.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCTrainingUnitLibrary.h"
#import "FBCExercise.h"
#import "FBCTraining.h"

static const NSString *kFBCExerciseKey = @"allExercises";
static const NSString *kFBCTrainingKey = @"trainings";

static FBCTrainingUnitLibrary *g_Library = nil;

@implementation FBCTrainingUnitLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class methods

+ (FBCTrainingUnitLibrary*)library
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_Library = [[FBCTrainingUnitLibrary alloc] init];
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
    NSMutableArray *trainingArray = [NSMutableArray arrayWithCapacity:_trainings.count];
    
    [_trainings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id<FBCTrainingUnitProtocol> unit = obj;
        NSDictionary *structure = [unit structure];
        
        [trainingArray addObject:structure];
    }];
    
    NSMutableArray *exerciseArray = [NSMutableArray arrayWithCapacity:_allExercises.count];
    
    [_allExercises enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id<FBCTrainingUnitProtocol> unit = obj;
        NSDictionary *structure = [unit structure];
        
        [exerciseArray addObject:structure];
    }];
    
    NSMutableDictionary *structureDictionary = [NSMutableDictionary dictionaryWithCapacity:2];
    
    [structureDictionary setObject:trainingArray forKey:kFBCTrainingKey];
    [structureDictionary setObject:exerciseArray forKey:kFBCExerciseKey];

    NSURL *targetURL = FBCLibraryFile();
    NSData *libData = [NSJSONSerialization dataWithJSONObject:structureDictionary options:NSJSONWritingPrettyPrinted
                                                        error:nil];
    
    [libData writeToURL:targetURL atomically:YES];
}

- (void)loadStructure
{
    NSURL *targetURL = FBCLibraryFile();
    NSData *libData = [NSData dataWithContentsOfURL:targetURL];
    
    if (nil == libData)
    {
        [self __setInitState];
        
        return;
    }
    
    NSDictionary *structureDictionary = [NSJSONSerialization
                                         JSONObjectWithData:libData options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *trainings = [structureDictionary objectForKey:kFBCTrainingKey];
    NSMutableArray *exercises = [structureDictionary objectForKey:kFBCExerciseKey];
    
    if (nil != trainings)
    {
        _trainings = [NSMutableArray arrayWithCapacity:trainings.count];
        
        [trainings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *unitDict = obj;
            FBCTraining *training = [[FBCTraining alloc] initWithDictionary:unitDict];
            
            [_trainings addObject:training];
        }];
    }
    else
    {
        _trainings = [NSMutableArray arrayWithCapacity:1];
    }
    
    if (nil != exercises)
    {
        _allExercises = [NSMutableArray arrayWithCapacity:exercises.count];
        
        [exercises enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *unitDict = obj;
            FBCExercise *exercise = [[FBCExercise alloc] initWithDictionary:unitDict];
            
            [_allExercises addObject:exercise];
        }];
    }
    else
    {
        _allExercises = [NSMutableArray arrayWithCapacity:1];
    }
}

@end
