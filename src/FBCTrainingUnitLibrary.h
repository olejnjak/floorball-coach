//
//  FBCTrainingUnitLibrary.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FBCTraining;
@class FBCExercise;

@interface FBCTrainingUnitLibrary : NSObject
{
    @protected NSMutableArray *_allExercises;
    @protected NSMutableArray *_trainings;
}

+ (FBCTrainingUnitLibrary*)library;

- (void)addTraining:(FBCTraining*)training;
- (void)removeTraining:(FBCTraining*)training;

- (FBCTraining*)createNewTraining;
- (FBCExercise*)createNewExercise;

- (void)addExercise:(FBCExercise*)exercise;
- (void)removeExercise:(FBCExercise*)exercise;

- (NSArray*)exercises;
- (NSArray*)favoriteExercises;
- (NSMutableArray*)trainings;
- (NSArray*)flatTrainings;

- (void)loadStructure;
- (void)saveStructure;

@end
