//
//  FBCTraining.h
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBCTrainingUnitProtocol.h"

@class FBCExercise;

@interface FBCTraining : NSObject<FBCTrainingUnitProtocol>

@property (nonatomic,strong,readonly) NSDate *date;

- (NSArray*)exercises;
- (void)addExercise:(FBCExercise*)exercise;
- (void)addExercise:(FBCExercise *)exercise toIndex:(NSInteger)index;
- (void)addExercises:(NSArray*)exercises;
- (void)removeExercise:(FBCExercise*)exercise;

- (void)moveExerciseFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end
