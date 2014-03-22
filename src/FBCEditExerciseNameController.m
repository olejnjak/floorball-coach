//
//  FBCEditExerciseNameController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 22/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCEditExerciseNameController.h"
#import "FBCExercise.h"

@implementation FBCEditExerciseNameController

@synthesize exercise = _exercise;
@synthesize popController = _popController;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self resetNotifications];
    [self updateExerciseName];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.nameField becomeFirstResponder];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Notifications

- (void)resetNotifications
{
    [self.nameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(NSNotification*)notification
{
    NSString *value = [self.nameField text];
    
    if ([value length] > 0)
    {
        UIColor *clearColor = [UIColor clearColor];
        [self.nameField setBackgroundColor:clearColor];
        [self.saveButton setEnabled:YES];
    }
    
    else
    {
        UIColor *redColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];
        [self.nameField setBackgroundColor:redColor];
        [self.saveButton setEnabled:NO];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions

- (IBAction)saveButtonTapped:(UIButton *)sender
{
    [self save];
    
    [self.popController dismissPopoverAnimated:YES];
    [self.popController.delegate popoverControllerDidDismissPopover:self.popController];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)updateExerciseName
{
    NSString *exerciseName = [self.exercise name];
    
    [self.nameField setText:exerciseName];
}

- (void)save
{
    NSString *newName = [self.nameField text];
    
    [self.exercise setName:newName];
}

@end
