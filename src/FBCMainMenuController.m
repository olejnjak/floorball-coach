//
//  FBCMainMenuViewController.m
//  Floorbal Coach
//
//  Created by Jakub Olejnik on 10/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCMainMenuController.h"
#import "FBCMainMenuCellFactory.h"
#import "FBCAboutScreenController.h"
#import "FBCListViewController.h"
#import "FBCExerciseController.h"

@implementation FBCMainMenuController

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionView delegate -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UICollectionView datasource -

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reusableId =
        [FBCMainMenuCellFactory reusableIdForIndexPath:indexPath andOrientation:self.interfaceOrientation];
    
    UICollectionViewCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:reusableId forIndexPath:indexPath];
    
    return cell;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCControllerDone protocol -

- (void)controllerIsDone:(UIViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Rotation -

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    [self.mainMenu reloadData];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Segues -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = [segue identifier];
    
    if ([identifier isEqualToString:kFBCMainMenuToAboutSegue])
    {
        FBCAboutScreenController *dst = [segue destinationViewController];
        
        [dst setDelegate:self];
        return;
    }
    
    if ([identifier isEqualToString:kFBCMainMenuToExerciseListSegue])
    {
        FBCListViewController *dst = [segue destinationViewController];
        
        [dst setType:FBCListViewControllerTypeExercise];
        
        return;
    }
    
    if ([identifier isEqualToString:kFBCMainMenuToTrainingListSegue])
    {
        FBCListViewController *dst = segue.destinationViewController;
        
        [dst setType:FBCListViewControllerTypeTraining];
        
        return;
    }
    
    if ([identifier isEqualToString:kFBCMainMenuToExerciseSegue])
    {
        FBCExerciseController *dst = [segue destinationViewController];
        
        [dst setDelegate:self];
        
        return;
    }
}

@end
