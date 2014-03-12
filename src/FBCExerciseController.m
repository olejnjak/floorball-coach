//
//  FBCExerciseController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCExerciseController.h"

#define kFBCNotesShownConstant 0
#define kFBCNotesHiddenConstant -320

@implementation FBCExerciseController

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions

- (IBAction)notesButtonPressed:(id)sender
{
    [self toggleNotesPanel];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)toggleNotesPanel
{
    CGFloat panelConstant = self.notesTrailingConstraint.constant;
    
    // show panel
    if (panelConstant == kFBCNotesHiddenConstant)
    {
        self.notesTrailingConstraint.constant = kFBCNotesShownConstant;
    }
    
    // hide panel
    else
    {
        self.notesTrailingConstraint.constant = kFBCNotesHiddenConstant;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
