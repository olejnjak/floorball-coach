//
//  FBCTrainingDetailController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 23/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCTrainingDetailController.h"
#import "FBCTrainingDetailModel.h"
#import "FBCEditUnitNameController.h"
#import "FBCTraining.h"

@implementation FBCTrainingDetailController
{
    FBCTrainingDetailModel *_model;
    UIPopoverController *_popController;
}

@synthesize delegate = _delegate;
@synthesize training = _training;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (void)__setInitState
{
    _model = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSAssert(self.training != nil, @"Controller cannot have empty training.");
    
    [self __setInitState];
    
    [self.collectionView setDelegate:self.model];
    [self.collectionView setDataSource:self.model];
    
    [self.trainingName setTitle:self.training.name];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = [segue identifier];
    
    if ([identifier isEqualToString:kFBCEditTrainingNamePopoverSegue])
    {
        UIStoryboardPopoverSegue *theSegue = (UIStoryboardPopoverSegue*)segue;
        FBCEditUnitNameController *dst = [theSegue destinationViewController];
        
        [dst setUnit:self.training];
        
        UIPopoverController *popController = [theSegue popoverController];
        
        [popController setDelegate:self];
        [dst setPopController:popController];

        _popController = popController;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:kFBCEditTrainingNamePopoverSegue])
    {
        if (_popController != nil)
        {
            [_popController dismissPopoverAnimated:YES];
            [_popController.delegate popoverControllerDidDismissPopover:_popController];
            
            return NO;
        }
        
        return YES;
    }
    
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIPopoverControllerDelegate methods

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if (popoverController == _popController)
    {
        _popController = nil;
        
        [self.trainingName setTitle:self.training.name];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Custom properties

- (FBCTrainingDetailModel*)model
{
    if (nil == _model)
    {
        _model = [[FBCTrainingDetailModel alloc] initWithTraining:self.training];
    }
    
    return _model;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions

- (IBAction)backButtonTapped:(UIBarButtonItem *)sender
{
    if (self.delegate != nil)
    {
        [self.delegate controllerIsDone:self];
    }
}

@end
