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
    [self testData];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Test data preparation

- (void)testData
{
    const static NSUInteger maxUnits = 11;
    const NSUInteger unitsToGenerate = arc4random() % maxUnits;
    NSMutableArray *testArray = [NSMutableArray arrayWithCapacity:unitsToGenerate];
    
    for (NSUInteger i = 0; i < unitsToGenerate; i++)
    {
        NSUInteger type = arc4random() % 2;
        id<FBCTrainingUnitProtocol> unit = nil;
        
        //generate exercise
        if (type == 0)
        {
            unit = [self.class generateExercise];
        }
        
        //generate training
        else
        {
            unit = [self.class generateTraining];
        }
        
        [testArray addObject:unit];
    }

    _units = testArray;
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
