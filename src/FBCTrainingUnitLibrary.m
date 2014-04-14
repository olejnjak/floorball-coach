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

static NSString *kFBCExerciseKey = @"allExercises";
static NSString *kFBCTrainingKey = @"trainings";

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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Custom properties

- (NSMutableArray*)allExercises
{
    if (nil == _allExercises)
    {
        _allExercises = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    return _allExercises;
}

- (NSMutableArray*)trainings
{
    if (nil == _trainings)
    {
        _trainings = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    return _trainings;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public interface

- (NSArray*)exercises
{
    NSArray *result = [self.allExercises arrayByRemovingDuplicates];
    
    return result;
}

- (NSArray*)favoriteExercises
{
    NSArray *exercises = [self exercises];
    NSPredicate *favoritePredicate = [NSPredicate predicateWithFormat:@"favorite == YES"];
    NSArray *result = [exercises filteredArrayUsingPredicate:favoritePredicate];
    
    return result;
}

- (NSArray*)flatTrainings
{
    NSArray *trainings = [self trainings];
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
    [self.allExercises addObject:exercise];
}

- (void)addTraining:(FBCTraining *)training
{
    [self.trainings addObject:training];
}

- (void)removeTraining:(FBCTraining *)training
{
    [self.trainings removeObject:training];
}

- (void)removeExercise:(FBCExercise *)exercise
{
    NSURL *exerciseURL = FBCFolderForExercise(exercise);
    NSFileManager *fm = [NSFileManager defaultManager];
    
    [fm removeItemAtURL:exerciseURL error:nil];
    
    [self.allExercises removeObject:exercise];
}

- (FBCTraining*)createNewTraining
{
    FBCTraining *newTraining = [[FBCTraining alloc] initWithName:LOC(@"FBCNewTraining")];
    
    [self addTraining:newTraining];
    
    return newTraining;
}

- (FBCExercise*)createNewExercise
{
    FBCExercise *newExercise = [[FBCExercise alloc] initWithName:LOC(@"FBCNewExercise")];
    
    [self addExercise:newExercise];
    
    return newExercise;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Serialization

- (void)saveStructure
{
    NSMutableDictionary *libDict = [NSMutableDictionary dictionaryWithCapacity:2];
    NSURL *libFile = FBCLibraryFile();
    
    [libDict setObject:self.trainings forKey:kFBCTrainingKey];
    [libDict setObject:self.allExercises forKey:kFBCExerciseKey];
    
    [NSKeyedArchiver archiveRootObject:libDict toFile:libFile.path];
}

- (void)loadStructure
{
    NSURL *libFile = FBCLibraryFile();
    NSMutableDictionary *items = [NSKeyedUnarchiver unarchiveObjectWithFile:libFile.path];
    
    _trainings = [items objectForKey:kFBCTrainingKey];
    _allExercises = [items objectForKey:kFBCExerciseKey];
}

@end