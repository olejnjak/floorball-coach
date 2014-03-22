//
//  FBCFavoritesModel.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 22/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCFavoritesModel.h"
#import "FBCTrainingUnitLibrary.h"

@implementation FBCFavoritesModel

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Custom properties -

- (NSMutableArray*)exercises
{
    if (nil == _exercises)
    {
        FBCTrainingUnitLibrary *library = [FBCTrainingUnitLibrary library];
        NSArray *exercises = [library exercises];
        NSPredicate *favoritePredicate = [NSPredicate predicateWithFormat:@"favorite == YES"];
        
        _exercises = [[exercises filteredArrayUsingPredicate:favoritePredicate] mutableCopy];
    }
    
    return _exercises;
}

@end
