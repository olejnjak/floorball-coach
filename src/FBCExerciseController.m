//
//  FBCExerciseController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCExerciseController.h"
#import "FBCNotesPanelController.h"
#import "FBCEditUnitNameController.h"
#import "FBCFieldController.h"

#define kFBCNotesShownConstant 0
#define kFBCNotesHiddenConstant -320

@implementation FBCExerciseController
{
    UIPopoverController *_popoverController;
}

@synthesize delegate = _delegate;
@synthesize exercise = _exercise;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class methods

+ (FBCExerciseController*)instantiateFromStoryboard:(NSString *)storyboardID
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:kFBCMainStoryboard bundle:nil];
    
    FBCExerciseController *exerciseController = [storyboard instantiateViewControllerWithIdentifier:storyboardID];
    
    return exerciseController;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init and dealloc

- (void)__setInitState
{
    _popoverController = nil;
}

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc removeObserver:self];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSAssert(self.exercise != nil, @"Cannot start with no training set.");
    
    [self __setInitState];
    [self resetNotifications];
    [self updateExerciseName];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions

- (IBAction)notesButtonPressed:(UIBarButtonItem *)sender
{
    [self toggleNotesPanel];
}

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender
{
    [self.exercise saveNotes];
    [self.exercise setNotes:nil];
    
    [self.exercise saveDrawables];
    [self.exercise setDrawables:nil];
    
    if (self.delegate != nil)
    {
        [self.delegate controllerIsDone:self];
    }
}

- (IBAction)fieldTapped:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized && [self notesPanelShown])
    {
        [self hideNotesPanel];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Notifications

- (void)resetNotifications
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc removeObserver:self];
    
    [nc addObserver:self selector:@selector(applicationToBackgroundNotification:)
               name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)applicationToBackgroundNotification:(NSNotification*)notification
{
    [self.exercise saveNotes];
    [self.exercise saveDrawables];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Segues

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:kFBCEditExerciseNamePopoverSegue])
    {
        UIPopoverController *popoverController = _popoverController;
        
        if (nil != popoverController)
        {
            [popoverController dismissPopoverAnimated:YES];
            _popoverController = nil;
            
            return NO;
        }
    }
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = [segue identifier];
    
    if ([identifier isEqualToString:kFBCNotesEmbedSegue])
    {
        FBCNotesPanelController *dst = [segue destinationViewController];
        
        [dst setExercise:self.exercise];
        
        return;
    }
    
    if ([identifier isEqualToString:kFBCEditExerciseNamePopoverSegue])
    {
        FBCEditUnitNameController *dst = [segue destinationViewController];
        
        [dst setUnit:self.exercise];
        
        UIStoryboardPopoverSegue *theSegue = (UIStoryboardPopoverSegue*)segue;
        UIPopoverController *popController = [theSegue popoverController];

        [dst setPopController:popController];
        [popController setDelegate:self];
        
        _popoverController = popController;
        
        return;
    }
    
    if ([identifier isEqualToString:kFBCFieldControllerEmbedSegue])
    {
        FBCFieldController *dst = [segue destinationViewController];
        
        [dst setExercise:self.exercise];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIPopoverController delegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self updateExerciseName];
    
    if (_popoverController == popoverController)
    {
        _popoverController = nil;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Notes panel handling

- (void)toggleNotesPanel
{
    if ([self notesPanelShown])
    {
        [self hideNotesPanel];
    }
    else
    {
        [self showNotesPanel];
    }
}

- (BOOL)notesPanelShown
{
    CGFloat trailingSpaceConstant = [self.notesTrailingConstraint constant];
    
    return trailingSpaceConstant == kFBCNotesShownConstant;
}

- (void)hideNotesPanel
{
    [self setNotesPanelTrailingConstant:kFBCNotesHiddenConstant];
}

- (void)showNotesPanel
{
    [self setNotesPanelTrailingConstant:kFBCNotesShownConstant];
}

- (void)setNotesPanelTrailingConstant:(CGFloat)newConstant
{
    [self.notesTrailingConstraint setConstant:newConstant];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)updateExerciseName
{
    FBCExercise *exercise = [self exercise];
    
    [self.nameItem setTitle:exercise.name];
}

@end
