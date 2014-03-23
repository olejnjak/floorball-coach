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

- (id)initWithName:(NSString*)name;

- (NSArray*)exercises;
- (void)addExercise:(FBCExercise*)exercise;
- (void)addExercises:(NSArray*)exercises;
- (void)removeExercise:(FBCExercise*)exercise;

@end
