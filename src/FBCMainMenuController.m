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
#import "FBCTrainingUnitLibrary.h"
#import "FBCTrainingDetailController.h"
#import "FBCTraining.h"
#import "FBCIAPModel.h"
#import "FBCMainMenuAboutCell.h"

@implementation FBCMainMenuController

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods -

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[FBCIAPModel model] setDelegate:self];
    [[FBCIAPModel model] requestProductsFromApple];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[FBCIAPModel model] setDelegate:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

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
    
    NSString *aboutId = [NSString stringWithFormat:kFBCMainMenuCellFormat, (long)5];
    
    if ([reusableId isEqualToString:aboutId])
    {
        FBCMainMenuAboutCell *aboutCell = (FBCMainMenuAboutCell*)cell;
        BOOL iapAvailable = [[FBCIAPModel model] iapAvailable];
        BOOL bought = [[FBCIAPModel model] shouldDisplayAds] == NO;
        BOOL allowButtons = iapAvailable && !bought;
        
        [aboutCell.removeAdsButton setEnabled:allowButtons];
        [aboutCell.restoreButton setEnabled:allowButtons];
    }
    
    return cell;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCControllerDone protocol -

- (void)controllerIsDone:(UIViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCIAPModelDelegate methods - 

- (void)iapAvailableChanged:(BOOL)available
{
    [self.mainMenu reloadData];
}

- (void)adStateChanged:(BOOL)bought
{
    [self.mainMenu reloadData];
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
    
    // about screen
    if ([identifier isEqualToString:kFBCMainMenuToAboutSegue])
    {
        FBCAboutScreenController *dst = [segue destinationViewController];
        
        [dst setDelegate:self];
        return;
    }
    
    // exercise list
    if ([identifier isEqualToString:kFBCMainMenuToExerciseListSegue])
    {
        FBCListViewController *dst = [segue destinationViewController];
        
        [dst setType:FBCListViewControllerTypeExercise];
        
        return;
    }
    
    // training list
    if ([identifier isEqualToString:kFBCMainMenuToTrainingListSegue])
    {
        FBCListViewController *dst = [segue destinationViewController];
        
        [dst setType:FBCListViewControllerTypeTraining];
        
        return;
    }
    
    // training detail - new training
    if ([identifier isEqualToString:kFBCMainMenuToTrainingDetailSegue])
    {
        FBCTrainingDetailController *dst = [segue destinationViewController];
        FBCTraining *training = [FBCTrainingUnitLibrary.library createNewTraining];
        
        [dst setDelegate:self];
        [dst setTraining:training];
        
        return;
    }

    // favorite exercises
    if ([identifier isEqualToString:kFBCMainMenuToFavoritesSegue])
    {
        FBCListViewController *dst = [segue destinationViewController];
        
        [dst setType:FBCListViewControllerTypeFavorite];
        
        return;
    }
    
    // new exercise
    if ([identifier isEqualToString:kFBCMainMenuToExerciseSegue])
    {
        FBCExerciseController *dst = [segue destinationViewController];
        FBCExercise *exercise = [FBCTrainingUnitLibrary.library createNewExercise];
        
        [dst setExercise:exercise];
        [dst setDelegate:self];
        
        return;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions -

- (IBAction)removeAdsTapped:(UIButton *)sender
{
    [[FBCIAPModel model] buyRemoveAds];
}

- (IBAction)restoreTapped:(UIButton *)sender {
}
@end
