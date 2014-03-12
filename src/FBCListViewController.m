//
//  FBCListViewController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCListViewController.h"
#import "FBCListViewModelProtocol.h"
#import "FBCExerciseListModel.h"
#import "FBCTrainingListModel.h"
#import "FBCExerciseController.h"

@implementation FBCListViewController
{
    id<FBCListViewModelProtocol> _model;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (void)__setInitState
{
    NSAssert(self.type != FBCListViewControllerTypeUndefined, @"Unexpected controller type.");
    
    _model = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self __setInitState];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [self.model count];
    
    return count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reusableIdentifier = [self.model.class reusableCellIdentifierForIndexPath:indexPath];
    UITableViewCell *result = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier forIndexPath:indexPath];
    
    return result;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: handle item selection
    
    FBCExerciseController *exerciseController = [FBCExerciseController instantiateFromStoryboard:kFBCExerciseController];
    
    [exerciseController setDelegate:self];
    [exerciseController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentViewController:exerciseController animated:YES completion:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - FBCControllerDoneProtocol methods

- (void)controllerIsDone:(UIViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = [segue identifier];
    
    if ([identifier isEqualToString:kFBCListViewTypeChangeSegue])
    {
        FBCListViewController *dst = [segue destinationViewController];
        
        if (self.type == FBCListViewControllerTypeTraining)
        {
            [dst setType:FBCListViewControllerTypeExercise];
        }
        
        else if (self.type == FBCListViewControllerTypeExercise)
        {
            [dst setType:FBCListViewControllerTypeTraining];
        }
        
        return;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Custom properties

- (id<FBCListViewModelProtocol>)model
{
    if (_model == nil && self.type == FBCListViewControllerTypeExercise)
    {
        _model = [FBCExerciseListModel model];
    }
    
    else if (_model == nil && self.type == FBCListViewControllerTypeTraining)
    {
        _model = [FBCTrainingListModel model];
    }
    
    return _model;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

@end
