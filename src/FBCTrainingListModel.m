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
#import "FBCSortBlocks.h"

@implementation FBCTrainingListModel
{
    NSMutableArray *_trainings;
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
    id<FBCTrainingUnitProtocol> unit = [self.trainings objectAtIndex:index];
    
    if ([unit isKindOfClass:[FBCTraining class]])
    {
        return kFBCTrainingNameCell;
    }
    
    return kFBCTrainingExerciseCell;
}

- (void)prepareTableViewCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath
{
    NSUInteger index = [indexPath row];
    id<FBCTrainingUnitProtocol> unit = [self.trainings objectAtIndex:index];
    
    // show exercise
    if ([cell isKindOfClass:[FBCSimpleExerciseCell class]] && [unit isKindOfClass:[FBCExercise class]])
    {
        [self.class prepareSimpleExerciseCell:(FBCSimpleExerciseCell*)cell forExercise:(FBCExercise*)unit];
    }
    
    // show training
    else if ([cell isKindOfClass:[FBCTrainingCell class]] && [unit isKindOfClass:[FBCTraining class]])
    {
        [self.class prepareTrainingCell:(FBCTrainingCell*)cell forTraining:(FBCTraining*)unit];
    }
}

- (NSInteger)count
{
    return [self.trainings count];
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = [indexPath row];
    id<FBCTrainingUnitProtocol> objectToRemove = [self.trainings objectAtIndex:index];
    
    [self.trainings removeObject:objectToRemove];
    
    if ([objectToRemove isKindOfClass:[FBCTraining class]])
    {
        FBCTraining *training = (FBCTraining*)objectToRemove;
        FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
        
        [library removeTraining:training];
        
        [training.exercises enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.trainings removeObject:obj];
        }];
    }
    else
    {
        FBCExercise *exercise = (FBCExercise*)objectToRemove;
        FBCTraining *training = [exercise parent];
        
        [training removeExercise:exercise];
    }
}

- (id<FBCTrainingUnitProtocol>)unitAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSInteger size = [self.trainings count];
    
    if (row >= size || row < 0)
    {
        return nil;
    }
    
    FBCTraining *training = [self.trainings objectAtIndex:row];
    
    return training;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Sort

- (void)sortAZ
{
    [self sortUsingComparator:kFBCAtoZBlock];
}

- (void)sortZA
{
    [self sortUsingComparator:kFBCZtoABlock];
}

- (void)sortNewFirst
{
    [self sortUsingComparator:kFBCNewFirstBlock];
}

- (void)sortOldFirst
{
    [self sortUsingComparator:kFBCOldFirstBlock];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Custom properties -

- (NSMutableArray*)trainings
{
    if (_trainings == nil)
    {
        FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
        NSMutableArray *trainingArray = [library.flatTrainings mutableCopy];
        
        _trainings = trainingArray;
    }
    
    return _trainings;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)sortUsingComparator:(NSComparator)comparator
{
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
    NSMutableArray *trainings = [library.trainings mutableCopy];
    
    [trainings sortUsingComparator:comparator];
    
    _trainings = [self.class flattenTrainingArray:trainings];
}

+ (NSMutableArray*)flattenTrainingArray:(NSArray*)trainingArray;
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:trainingArray.count];
    
    [trainingArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FBCTraining *training = obj;
        NSArray *flatTraining = [training flatten];
        
        [result addObjectsFromArray:flatTraining];
    }];
    
    return result;
}

+ (void)prepareSimpleExerciseCell:(FBCSimpleExerciseCell*)cell forExercise:(FBCExercise*)exercise
{
    [cell.nameLabel setText:exercise.name];
}

+ (void)prepareTrainingCell:(FBCTrainingCell*)cell forTraining:(FBCTraining*)training
{
    NSString *date = [training.date localString];
    NSUInteger exerciseCount = [training.exercises count];
    NSString *exerciseCountString = [NSString stringWithFormat:@"%lu", (unsigned long)exerciseCount];
    
    [cell.nameLabel setText:training.name];
    [cell.dateLabel setText:date];
    [cell.exerciseNumberLabel setText:exerciseCountString];
    [cell setTraining:training];
}

@end
