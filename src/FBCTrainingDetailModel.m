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
    
    if (section == kFBCRestOfExercisesSection)
    {
        [self.training addExercise:exercise];
    }
    
    [collectionView reloadDataAnimated:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FBCExercise *exercise = [self exerciseForIndexPath:indexPath];
    
    if (nil == exercise)
    {
        LXReorderableCollectionViewFlowLayout *layout = (LXReorderableCollectionViewFlowLayout*)collectionViewLayout;
        CGSize selfSize = collectionView.bounds.size;
        UIEdgeInsets insets = layout.sectionInset;
        
        selfSize.height = 20;
        selfSize.width -= insets.left;
        selfSize.width -= insets.right;
        
        return selfSize;
    }
    
    return CGSizeMake(200, 200);
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
            NSString *exceptionReason = [NSString stringWithFormat:@"Unknown section index (%ld).", (long)section];
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
    
    if ([self isPlaceholderAtIndexPath:indexPath])
    {
        [cell setHidden:YES];
    }
    else
    {
        [cell setHidden:NO];
    }
    
    [cell.nameLabel setText:exercise.name];
    [cell setExercise:exercise];
    
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
#pragma mark - LXReorderableCollectionViewDataSource methods

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO == [self isPlaceholderAtIndexPath:indexPath];
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath
    canMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    NSInteger fromSection = [fromIndexPath section];
    NSInteger toSection = [toIndexPath section];
    FBCExercise *exercise = [self exerciseForIndexPath:fromIndexPath];
    
    // allow move to placeholder index path only when section is empty
    if ([self isPlaceholderAtIndexPath:toIndexPath] && [toIndexPath row] > 0)
    {
        return NO;
    }
    
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];

    // never allow move to favorites
    if (toSection == kFBCFavoriteExercisesSection)
    {
        return [library.favoriteExercises containsObject:exercise];
    }
    
    // allow move to favorites only for favorites
    if (toSection == kFBCRestOfExercisesSection)
    {
        BOOL favoritesContainsExercise = [library.favoriteExercises containsObject:exercise];
        if (YES == favoritesContainsExercise)
        {
            return NO;
        }
    }
    
    // from favorites to training exercises
    if (fromSection == kFBCFavoriteExercisesSection && toSection == kFBCTrainingExercisesSection)
    {
        return YES;
    }

    // from all exercises to training exercises
    else if (fromSection == kFBCRestOfExercisesSection && toSection == kFBCTrainingExercisesSection)
    {
        return YES;
    }
    
    // reorder in training exercises
    else if (fromSection == kFBCTrainingExercisesSection && toSection == kFBCTrainingExercisesSection)
    {
        return YES;
    }
    
    // remove exercise from training (drag only to all exercises not favorites)
    else if (fromSection == kFBCTrainingExercisesSection && toSection == kFBCRestOfExercisesSection)
    {
        return YES;
    }
    
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath
   willMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    NSInteger fromSection = [fromIndexPath section];
    NSInteger toSection = [toIndexPath section];
    NSInteger fromIndex = [fromIndexPath row];
    NSInteger toIndex = [toIndexPath row];
    FBCExercise *exercise = [self exerciseForIndexPath:fromIndexPath];
    
    // reorder exercises
    if (fromSection == kFBCTrainingExercisesSection && fromSection == toSection)
    {
        [self.training moveExerciseFromIndex:fromIndex toIndex:toIndex];
    }
    
    // remove exercise from training
    else if (fromSection == kFBCTrainingExercisesSection && toSection == kFBCRestOfExercisesSection)
    {
        [self.training removeExercise:exercise];
    }
    
    // move from favorites or rest to training exercises
    else if ((fromSection == kFBCRestOfExercisesSection || fromSection == kFBCFavoriteExercisesSection)
             && toSection == kFBCTrainingExercisesSection)
    {
        [self.training addExercise:exercise toIndex:toIndex];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (NSUInteger)trainingExercisesCount
{
    NSArray *exercises = [self trainingExercises];
    
    return [exercises count] + 1;
}

- (NSUInteger)favoriteExercisesCount
{
    NSArray *favoriteExercises = [self favoriteExercises];
    
    return [favoriteExercises count] + 1;
}

- (NSUInteger)restOfExercisesCount
{
    NSArray *exercises = [self restOfExercises];
    
    return [exercises count] + 1;
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
    NSArray *favoriteExercises = [library favoriteExercises];
    NSMutableArray *allExercises = [library.exercises mutableCopy];
    
    [allExercises removeObjectsInArray:trainingExercises];
    [allExercises removeObjectsInArray:favoriteExercises];
    
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
            NSString *exceptionReason = [NSString stringWithFormat:@"Unknown section index (%ld).", (long)section];
            [[[NSException alloc] initWithName:@"Illegal section exception" reason:exceptionReason userInfo:nil] raise];
        }
    }
    
    if (nil == exerciseArray)
    {
        return nil;
    }
    
    NSInteger index = [indexPath row];
    
    if (index >= [exerciseArray count])
    {
        return nil;
    }
    
    FBCExercise *exercise = [exerciseArray objectAtIndex:index];
    
    return exercise;
}

- (BOOL)isPlaceholderAtIndexPath:(NSIndexPath*)indexPath
{
    // if model doesn't contain exercise for represented index path, it is a placeholder
    FBCExercise *exercise = [self exerciseForIndexPath:indexPath];
    
    return exercise == nil;
}

@end
