//
//  TestFBCTrainingUnitLibrary.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "TestFBCTrainingUnitLibrary.h"
#import "FBCExercise.h"
#import "FBCTraining.h"

@implementation TestFBCTrainingUnitLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and deallloc

- (void)__setInitState
{
    _allExercises = [NSMutableArray arrayWithCapacity:1];
    _trainings = [NSMutableArray arrayWithCapacity:1];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Test data preparation

- (void)testData
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        const NSUInteger unitsToGenerate = 10;
        
        for (NSUInteger i = 0; i < unitsToGenerate; i++)
        {
            NSUInteger type = i % 2;
            
            //generate exercise
            if (type == 0)
            {
                FBCExercise *exercise = [self.class generateExercise];
                
                [self addExercise:exercise];
            }
            
            //generate training
            else
            {
                FBCTraining *training = [self.class generateTraining];
                
                [self addTraining:training];
            }
        }
    });
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Superclass override

- (NSArray*)exercises
{
    [self testData];
    
    return [super exercises];
}

- (NSArray*)flatTrainings
{
    [self testData];
    
    return [super flatTrainings];
}

- (NSArray*)trainings
{
    [self testData];
    
    return [super exercises];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

+ (FBCExercise*)generateExercise
{
    NSString *exerciseName = [self.class randomString];
    
    FBCExercise *exercise = [[FBCExercise alloc] initWithName:exerciseName];
    
    return exercise;
}

+ (FBCTraining*)generateTraining
{
    const static NSUInteger maxExercises = 5;
    const NSUInteger exercisesToGenerate = arc4random() % maxExercises;
    
    NSString *trainingName = [self.class randomString];
    
    FBCTraining *training = [[FBCTraining alloc] initWithName:trainingName];
    
    for (NSUInteger i = 0; i < exercisesToGenerate; i++)
    {
        FBCExercise *exercise = [self.class generateExercise];
        
        [training addExercise:exercise];
    }
    
    return training;
}

+ (NSString*)randomString
{
    const static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    const static NSUInteger minLength = 10;
    const static NSUInteger maxLength = 20;
    const NSUInteger length = arc4random() % (maxLength - 10) + minLength;
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: length];
    
    for (NSUInteger i = 0; i < length; i++)
    {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

@end
