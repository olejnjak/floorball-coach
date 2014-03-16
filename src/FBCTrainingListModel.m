//
//  FBCTrainingListModel.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCTrainingListModel.h"
#import "FBCSimpleExerciseCell.h"
#import "FBCTrainingCell.h"
#import "FBCExercise.h"
#import "FBCTraining.h"
#import "FBCTrainingUnitLibrary.h"

@implementation FBCTrainingListModel
{
    NSMutableArray *_trainings;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
        [self __setInitState];
    }
    
    return self;
}

- (void)__setInitState
{
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
    
    _trainings = [library.flatTrainings mutableCopy];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCListViewModelProtocol methods

+ (id<FBCListViewModelProtocol>)model
{
    return [[self.class alloc] init];
}

- (NSString*)reusableCellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    id<FBCTrainingUnitProtocol> unit = [_trainings objectAtIndex:index];
    
    if ([unit isKindOfClass:[FBCTraining class]])
    {
        return kFBCTrainingNameCell;
    }
    
    return kFBCTrainingExerciseCell;
}

- (void)prepareTableViewCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath
{
    NSUInteger index = [indexPath row];
    id<FBCTrainingUnitProtocol> unit = [_trainings objectAtIndex:index];
    
    // show exercise
    if ([cell isKindOfClass:[FBCSimpleExerciseCell class]] && [unit isKindOfClass:[FBCExercise class]])
    {
        [self prepareSimpleExerciseCell:(FBCSimpleExerciseCell*)cell forExercise:(FBCExercise*)unit];
    }
    
    // show training
    else if ([cell isKindOfClass:[FBCTrainingCell class]] && [unit isKindOfClass:[FBCTraining class]])
    {
        [self prepareTrainingCell:(FBCTrainingCell*)cell forTraining:(FBCTraining*)unit];
    }
}

- (NSInteger)count
{
    return [_trainings count];
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = [indexPath row];
    id<FBCTrainingUnitProtocol> objectToRemove = [_trainings objectAtIndex:index];
    
    [_trainings removeObject:objectToRemove];
    
    if ([objectToRemove isKindOfClass:[FBCTraining class]])
    {
        FBCTraining *training = objectToRemove;
        FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
        
        [library removeTraining:training];
        
        [training.exercises enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [_trainings removeObject:obj];
        }];
    }
    else
    {
        FBCExercise *exercise = objectToRemove;
        FBCTraining *training = [exercise parent];
        
        [training removeExercise:exercise];
    }
}

- (id<FBCTrainingUnitProtocol>)unitForIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = [indexPath row];
    
    return [_trainings objectAtIndex:index];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)prepareSimpleExerciseCell:(FBCSimpleExerciseCell*)cell forExercise:(FBCExercise*)exercise
{
    [cell.nameLabel setText:exercise.name];
}

- (void)prepareTrainingCell:(FBCTrainingCell*)cell forTraining:(FBCTraining*)training
{
    NSString *date = [training.date localString];
    NSUInteger exerciseCount = [training.exercises count];
    NSString *exerciseCountString = [NSString stringWithFormat:@"%u", exerciseCount];
    
    [cell.nameLabel setText:training.name];
    [cell.dateLabel setText:date];
    [cell.exerciseNumberLabel setText:exerciseCountString];
}

@end
