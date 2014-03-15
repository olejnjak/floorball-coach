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
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self __setInitState];
    [self updateToolbar];
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
    NSString *reusableIdentifier = [self.model reusableCellIdentifierForIndexPath:indexPath];
    UITableViewCell *result = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier forIndexPath:indexPath];
    
    [self.model prepareTableViewCell:result forIndexPath:indexPath];
    
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.model deleteRowAtIndexPath:indexPath];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)setEditing:(BOOL)editing
{
    [super setEditing:editing];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
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
#pragma mark - UI actions

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender
{
    [self editTableView];
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender
{
    [self doneEditingTableView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)__setInitState
{
    NSAssert(self.type != FBCListViewControllerTypeUndefined, @"Unexpected controller type.");
    
    _model = nil;
}

- (void)editTableView
{
    [self.tableView setEditing:YES animated:YES];
    [self updateToolbar];
}

- (void)doneEditingTableView
{
    [self.tableView setEditing:NO animated:YES];
    [self updateToolbar];
}

- (void)updateToolbar
{
    UITableView *tableView = self.tableView;
    UIToolbar *toolbar = self.toolbar;
    NSMutableArray *toolbarItems = [toolbar.items mutableCopy];
    
    if (tableView.editing)
    {
        [toolbarItems removeObject:self.editButton];
        
        if ([toolbarItems containsObject:self.doneButton] == NO)
        {
            [toolbarItems addObject:self.doneButton];
        }
    }

    else
    {
        [toolbarItems removeObject:self.doneButton];
        
        if ([toolbarItems containsObject:self.editButton] == NO)
        {
            [toolbarItems addObject:self.editButton];
        }
    }
    
    [toolbar setItems:toolbarItems animated:YES];
}

@end
