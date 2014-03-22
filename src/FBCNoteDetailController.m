//
//  FBCNoteDetailControllerViewController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 21/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCNoteDetailController.h"
#import "FBCNote.h"
#import "FBCExercise.h"

@implementation FBCNoteDetailController

@synthesize exercise = _exercise;
@synthesize popController = _popController;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSAssert(self.exercise != nil, @"Cannot create note which is not associated with exercise.");
    
    [self prepareViews];
    [self resetNotifications];
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
#pragma mark - UITextViewDelegate methods

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] > 0)
    {
        UIColor *color = [UIColor clearColor];
        
        [textView setBackgroundColor:color];
        [self.saveButton setEnabled:YES];
    }
    else
    {
        UIColor *color = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];
        
        [textView setBackgroundColor:color];
        [self.saveButton setEnabled:NO];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Notifications

- (void)resetNotifications
{
    [self.nameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange:(NSNotification*)notification
{
    UITextField *textField = [self nameField];
    
    if ([textField.text length] > 0)
    {
        UIColor *color = [UIColor clearColor];
        
        [textField setBackgroundColor:color];
        [self.saveButton setEnabled:YES];
    }
    else
    {
        UIColor *color = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];
        
        [textField setBackgroundColor:color];
        [self.saveButton setEnabled:NO];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (void)save
{
    NSDate *date = [NSDate date];
    NSString *text = [self.contentTextView text];
    NSString *name = [self.nameField text];
    
    FBCNote *note = [[FBCNote alloc] init];
    
    [note setText:text];
    [note setName:name];
    [note setDateCreated:date];
    
    [self.exercise addNote:note];
}

- (void)prepareViews
{
    UIView *content = [self contentTextView];
    
    content.layer.borderWidth = 1.0f;
    content.layer.borderColor = [UIColor.lightGrayColor CGColor];
    content.layer.cornerRadius = 5.0f;
    [content setClipsToBounds:YES];
    
    content = [self nameField];
    
    content.layer.borderWidth = 1.0f;
    content.layer.borderColor = [UIColor.lightGrayColor CGColor];
    content.layer.cornerRadius = 5.0f;
    [content setClipsToBounds:YES];
}

@end
