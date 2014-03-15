//
//  FBCExerciseListModel.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCExerciseListModel.h"

@implementation FBCExerciseListModel
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

+ (NSString*)reusableCellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    return kFBCExerciseListCell;
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
