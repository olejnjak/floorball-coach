//
//  FBCExerciseListModel.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCExerciseListModel.h"
#import "FBCTrainingUnitLibrary.h"
#import "FBCComplexExerciseCell.h"
#import "FBCExercise.h"

@implementation FBCExerciseListModel
{
    NSMutableArray *_exercises;
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
    _exercises = [library.exercises mutableCopy];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCListViewModelProtocol methods

+ (id<FBCListViewModelProtocol>)model
{
    return [[self.class alloc] init];
}

- (NSString*)reusableCellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    return kFBCExerciseListCell;
}

- (void)prepareTableViewCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath
{
    if (NO == [cell isKindOfClass:[FBCComplexExerciseCell class]])
    {
        return;
    }
    
    FBCComplexExerciseCell *complexCell = (FBCComplexExerciseCell*)cell;
    NSUInteger index = [indexPath row];
    FBCExercise *exercise = [_exercises objectAtIndex:index];
    NSString *date = [exercise.dateCreated localString];
    
    [complexCell.nameLabel setText:exercise.name];
    [complexCell.dateLabel setText:date];
}

- (NSInteger)count
{
    return [_exercises count];
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [indexPath row];
    id<FBCTrainingUnitProtocol> objectToRemove = [_exercises objectAtIndex:index]; // TODO: Check if index is out of bounds.
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
    
    [_exercises removeObjectAtIndex:index];
    [library removeUnit:objectToRemove];
}

@end
