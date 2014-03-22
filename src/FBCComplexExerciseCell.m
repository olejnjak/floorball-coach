//
//  FBCComplexExerciseCell.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 15/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCComplexExerciseCell.h"
#import "FBCExercise.h"

@implementation FBCComplexExerciseCell

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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)updateFavoriteButton
{
    BOOL favorited = [self.exercise favorite];
    
    if (YES == favorited)
    {
        [self.favoriteButton setTitle:LOC(@"FBCFavorited") forState:UIControlStateNormal];
    }
    else
    {
        [self.favoriteButton setTitle:LOC(@"FBCFavorite") forState:UIControlStateNormal];        
    }
}

@end
