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
    FBCExercise *exerciseToRemove = [_exercises objectAtIndex:index]; // TODO: Check if index is out of bounds.
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
    
    [_exercises removeObjectAtIndex:index];
    [library removeExercise:exerciseToRemove];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Sort

- (void)sortAZ
{
    [_exercises sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FBCExercise *e1 = obj1;
        FBCExercise *e2 = obj2;
        
        NSString *e1name = [e1.name lowercaseString];
        NSString *e2name = [e2.name lowercaseString];
        
        return [e1name compare:e2name];
    }];
}

- (void)sortZA
{
    [_exercises sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FBCExercise *e1 = obj1;
        FBCExercise *e2 = obj2;
        
        NSString *e1name = [e1.name lowercaseString];
        NSString *e2name = [e2.name lowercaseString];
        
        return [e2name compare:e1name];
    }];
}

- (void)sortNewFirst
{
    [_exercises sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FBCExercise *e1 = obj1;
        FBCExercise *e2 = obj2;
        
        return [e1.dateCreated compare:e2.dateCreated];
    }];
}

- (void)sortOldFirst
{
    [_exercises sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FBCExercise *e1 = obj1;
        FBCExercise *e2 = obj2;
        
        return [e2.dateCreated compare:e1.dateCreated];
    }];
}

@end
