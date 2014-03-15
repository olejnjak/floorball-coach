//
//  FBCTrainingListModel.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCTrainingListModel.h"

@implementation FBCTrainingListModel
{
    NSInteger _count;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
        _count = 5;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCListViewModelProtocol methods

+ (id<FBCListViewModelProtocol>)model
{
    return [[self.class alloc] init];
}

- (NSString*)reusableCellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (row == 0)
    {
        return kFBCTrainingNameCell;
    }
    
    return kFBCTrainingExerciseCell;
}

- (void)prepareTableViewCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath
{
    
}

- (NSInteger)count
{
    return _count;
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath
{
    _count--;
}

@end
