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
#import "FBCFavoritesModel.h"
#import "FBCExerciseController.h"
#import "FBCTraining.h"
#import "FBCSortViewController.h"
#import "FBCTrainingDetailController.h"

@implementation FBCListViewController
{
    id<FBCListViewModelProtocol> _model;
    id<FBCTrainingUnitProtocol> _selectedUnit;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (void)__setInitState
{
    NSAssert(self.type != FBCListViewControllerTypeUndefined, @"Unexpected controller type.");
    
    _model = nil;
    _selectedUnit = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateToolbar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self __setInitState];
    [self.tableView reloadData];
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
    id<FBCTrainingUnitProtocol> unit = [self.model unitAtIndexPath:indexPath];
    
    _selectedUnit = unit;
    
    // if training is selected, don't do anything
    if ([unit isKindOfClass:[FBCTraining class]])
    {
        [self performSegueWithIdentifier:kFBCListToTrainingDetailSegue sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:kFBCListToExerciseSegue sender:self];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [self.model deleteRowAtIndexPath:indexPath];
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
    
    // list view type change
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
    
    // sort popover
    if ([identifier isEqualToString:kFBCSortPopoverSegue])
    {
        [self sortPopoverSegue:segue];
        
        return;
    }
    
    // exercise selected
    if ([identifier isEqualToString:kFBCListToExerciseSegue])
    {
        FBCExerciseController *dst = [segue destinationViewController];
        
        [dst setDelegate:self];
        [dst setExercise:_selectedUnit];
        
        _selectedUnit = nil;
        
        return;
    }
    
    // training selected
    if ([identifier isEqualToString:kFBCListToTrainingDetailSegue])
    {
        FBCTrainingDetailController *dst = [segue destinationViewController];
        
        [dst setDelegate:self];
        [dst setTraining:_selectedUnit];
        
        _selectedUnit = nil;
        
        return;
    }
}

- (void)sortPopoverSegue:(UIStoryboardSegue*)segue
{
    UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue*)segue;
    FBCSortViewController *dst = [popoverSegue destinationViewController];
    UIPopoverController *popover = [popoverSegue popoverController];
    __weak FBCListViewController *weakSelf = self;
    
    [dst setPopover:popover];
    
    [dst setAToZBlock:^{
        [weakSelf.model sortAZ];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [dst setZToABlock:^{
        [weakSelf.model sortZA];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [dst setOldFirstBlock:^{
        [weakSelf.model sortOldFirst];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [dst setNewFirstBlock:^{
        [weakSelf.model sortNewFirst];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
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
    
    else if (_model == nil && self.type == FBCListViewControllerTypeFavorite)
    {
        _model = [FBCFavoritesModel model];
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
    
    if (YES == tableView.editing)
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
