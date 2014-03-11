//
//  FBCTrainingListModel.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCTrainingListModel.h"

@implementation FBCTrainingListModel

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCListViewModelProtocol methods

+ (id<FBCListViewModelProtocol>)model
{
    return [[self.class alloc] init];
}

+ (NSString*)reusableCellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (row == 0)
    {
        return kFBCTrainingNameCell;
    }
    
    return kFBCTrainingExerciseCell;
}

- (NSInteger)count
{
    return 5;
}

@end
