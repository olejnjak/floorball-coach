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
    FBCExercise *exercise = [self.exercises objectAtIndex:index];
    NSString *date = [exercise.dateCreated localString];
    
    [complexCell.nameLabel setText:exercise.name];
    [complexCell.dateLabel setText:date];
}

- (NSInteger)count
{
    return [self.exercises count];
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [indexPath row];
    FBCExercise *exerciseToRemove = [self.exercises objectAtIndex:index]; // TODO: Check if index is out of bounds.
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
    
    [self.exercises removeObjectAtIndex:index];
    [library removeExercise:exerciseToRemove];
}

- (id<FBCTrainingUnitProtocol>)unitAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSInteger size = [self.exercises count];
    
    if (row >= size || row < 0)
    {
        return nil;
    }
    
    FBCExercise *exercise = [self.exercises objectAtIndex:row];
    
    return exercise;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Sort

- (void)sortAZ
{
    [self.exercises sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FBCExercise *e1 = obj1;
        FBCExercise *e2 = obj2;
        
        NSString *e1name = [e1.name lowercaseString];
        NSString *e2name = [e2.name lowercaseString];
        
        return [e1name compare:e2name];
    }];
}

- (void)sortZA
{
    [self.exercises sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FBCExercise *e1 = obj1;
        FBCExercise *e2 = obj2;
        
        NSString *e1name = [e1.name lowercaseString];
        NSString *e2name = [e2.name lowercaseString];
        
        return [e2name compare:e1name];
    }];
}

- (void)sortNewFirst
{
    [self.exercises sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FBCExercise *e1 = obj1;
        FBCExercise *e2 = obj2;
        
        return [e1.dateCreated compare:e2.dateCreated];
    }];
}

- (void)sortOldFirst
{
    [self.exercises sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        FBCExercise *e1 = obj1;
        FBCExercise *e2 = obj2;
        
        return [e2.dateCreated compare:e1.dateCreated];
    }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Custom properties -

- (NSMutableArray*)exercises
{
    if (nil == _exercises)
    {
        FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
        _exercises = [library.exercises mutableCopy];
    }
    
    return _exercises;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers -


@end
