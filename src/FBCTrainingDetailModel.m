//
//  FBCTrainingDetailModel.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 23/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCTrainingDetailModel.h"
#import "FBCTraining.h"
#import "FBCTrainingDetailCell.h"
#import "FBCTrainingUnitLibrary.h"
#import "FBCExercise.h"
#import "FBCTrainingDetailSectionHeaderView.h"

static const NSInteger kFBCTrainingExercisesSection = 0;
static const NSInteger kFBCFavoriteExercisesSection = 1;
static const NSInteger kFBCRestOfExercisesSection = 2;

@implementation FBCTrainingDetailModel

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (id)init
{
    return nil;
}

- (id)initWithTraining:(FBCTraining *)training
{
    self = [super init];
    
    if (nil != self)
    {
        [self setTraining:training];
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    FBCExercise *exercise = [self exerciseForIndexPath:indexPath];
    
    if (section == kFBCTrainingExercisesSection)
    {
        [self.training removeExercise:exercise];
    }
    else
    {
        [self.training addExercise:exercise];
    }
    
    [collectionView reloadDataAnimated:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section)
    {
        case kFBCTrainingExercisesSection:
            return [self trainingExercisesCount];
        case kFBCFavoriteExercisesSection:
            return [self favoriteExercisesCount];
        case kFBCRestOfExercisesSection:
            return [self restOfExercisesCount];
            
        // This code should be never reached.
        default:
        {
            NSString *exceptionReason = [NSString stringWithFormat:@"Unknown section index (%d).", section];
            [[[NSException alloc] initWithName:@"Illegal section exception" reason:exceptionReason userInfo:nil] raise];
        }
    }
    
    return NSNotFound;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FBCTrainingDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFBCTrainingDetailCell
                                                                            forIndexPath:indexPath];
    
    FBCExercise *exercise = [self exerciseForIndexPath:indexPath];
    
    [cell.nameLabel setText:exercise.name];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader)
    {
        FBCTrainingDetailSectionHeaderView *header = [collectionView
                                                      dequeueReusableSupplementaryViewOfKind:kind
                                                      withReuseIdentifier:kFBCTrainingDetailSectionHeaderView
                                                      forIndexPath:indexPath];
        NSString *localizationKey = nil;
        NSInteger section = [indexPath section];
        
        switch (section)
        {
            case kFBCTrainingExercisesSection:
                localizationKey = @"FBCTrainingExercises";
                break;
            case kFBCFavoriteExercisesSection:
                localizationKey = @"FBCFavoriteExercises";
                break;
            case kFBCRestOfExercisesSection:
                localizationKey = @"FBCRestOfExercises";
                break;
        }
        
        if (nil != localizationKey)
        {
            [header.nameLabel setText:LOC(localizationKey)];
        }
        
        return header;
    }
    
    return nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (NSUInteger)trainingExercisesCount
{
    NSArray *exercises = [self trainingExercises];
    
    return [exercises count];
}

- (NSUInteger)favoriteExercisesCount
{
    NSArray *favoriteExercises = [self favoriteExercises];
    
    return [favoriteExercises count];
}

- (NSUInteger)restOfExercisesCount
{
    NSArray *exercises = [self restOfExercises];
    
    return [exercises count];
}

- (NSArray*)trainingExercises
{
    return [self.training exercises];
}

- (NSArray*)favoriteExercises
{
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
    NSArray *trainingExercises = [self.training exercises];
    NSMutableArray *favoriteExercises = [library.favoriteExercises mutableCopy];
    
    [favoriteExercises removeObjectsInArray:trainingExercises];
    
    return favoriteExercises;
}

- (NSArray*)restOfExercises
{
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
    NSArray *trainingExercises = [self.training exercises];
    NSMutableArray *allExercises = [library.exercises mutableCopy];
    
    [allExercises removeObjectsInArray:trainingExercises];
    
    return allExercises;
}

- (FBCExercise*)exerciseForIndexPath:(NSIndexPath*)indexPath
{
    NSInteger section = [indexPath section];
    NSArray *exerciseArray = nil;
    
    switch (section)
    {
        case kFBCTrainingExercisesSection:
            exerciseArray = [self trainingExercises];
            break;
        case kFBCFavoriteExercisesSection:
            exerciseArray = [self favoriteExercises];
            break;
        case kFBCRestOfExercisesSection:
            exerciseArray = [self restOfExercises];
            break;
         
        // This code should be never reached.
        default:
        {
            NSString *exceptionReason = [NSString stringWithFormat:@"Unknown section index (%d).", section];
            [[[NSException alloc] initWithName:@"Illegal section exception" reason:exceptionReason userInfo:nil] raise];
        }
    }
    
    if (nil == exerciseArray)
    {
        return nil;
    }
    
    NSInteger index = [indexPath row];
    FBCExercise *exercise = [exerciseArray objectAtIndex:index];
    
    return exercise;
}

@end
