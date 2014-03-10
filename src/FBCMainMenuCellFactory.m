//
//  FBCMainMenuCellFactory.m
//  Floorbal Coach
//
//  Created by Jakub Olejnik on 10/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCMainMenuCellFactory.h"

#define kFBCReusableIdFormat @"FBCCollectionViewCell%d"

@implementation FBCMainMenuCellFactory

+ (NSString*)reusableIdForIndexPath:(NSIndexPath *)indexPath andOrientation:(UIInterfaceOrientation)orientation
{
    NSInteger row = indexPath.row;
    NSString *cellId = nil;
    
    // in portrait the consequence is 0,1,2,3,4,5
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        cellId = [NSString stringWithFormat:kFBCReusableIdFormat, row];
    }
    
    // in landscape the consequence is 0,2,4,1,3,5
    else
    {
        NSUInteger cellNumber = row * 2 % 5;
        
        if (row == 5)
        {
            cellNumber = 5;
        }
        
        cellId = [NSString stringWithFormat:kFBCReusableIdFormat, cellNumber];
    }
    
    return cellId;
}

@end
