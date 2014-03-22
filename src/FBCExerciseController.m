//
//  FBCExerciseController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCExerciseController.h"
#import "FBCNotesPanelController.h"

#define kFBCNotesShownConstant 0
#define kFBCNotesHiddenConstant -320

@implementation FBCExerciseController

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
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSAssert(self.exercise != nil, @"Cannot start with no training set.");
    
    [self updateUI];
    [self loadExercise];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions

- (IBAction)notesButtonPressed:(UIBarButtonItem *)sender
{
    [self toggleNotesPanel];
}

- (IBAction)backButtonPressed:(UIBarButtonItem *)sender
{
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
#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = [segue identifier];
    
    if ([identifier isEqualToString:kFBCNotesEmbedSegue])
    {
        FBCNotesPanelController *dst = [segue destinationViewController];
        
        [dst setExercise:self.exercise];
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

- (void)updateUI
{
    FBCExercise *exercise = [self exercise];
    
    [self.nameLabel setText:exercise.name];
}

- (void)loadExercise
{
    
}

@end
