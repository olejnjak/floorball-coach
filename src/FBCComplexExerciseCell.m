//
//  FBCComplexExerciseCell.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCComplexExerciseCell.h"
#import "FBCExercise.h"
#import "FBCTrainingUnitLibrary.h"
#import "FBCListViewController.h"

@implementation FBCComplexExerciseCell

@synthesize exercise = _exercise;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIView override

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateFavoriteButton];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions

- (IBAction)favoriteButtonTapped:(UIButton *)sender
{
    BOOL favorited = [self.exercise favorite];
    BOOL newValue = !favorited;

    [self.exercise setFavorite:newValue];
    
    [self updateFavoriteButton];
}

- (IBAction)duplicateButtonTapped:(UIButton *)sender
{
    FBCExercise *duplicate = [self.exercise copy];
    NSString *name = [duplicate name];
    NSString *duplicateName = [name stringByAppendingString:LOC(@"FBCCopy")];
    FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
    
    [duplicate setName:duplicateName];
    [library addExercise:duplicate];
    
    [self.parent refresh];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)updateFavoriteButton
{
    BOOL favorited = [self.exercise favorite];
    
    [self.favoriteImage setHighlighted:favorited];
}

@end
