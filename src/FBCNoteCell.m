//
//  FBCNoteCell.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 21/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCNoteCell.h"
#import "FBCNote.h"

@implementation FBCNoteCell

@synthesize note = _note;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewCell methods

- (void)setEditing:(BOOL)editing
{
    [self setEditing:editing animated:NO];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (YES == editing)
    {
        [self.nameField setEnabled:YES];
        [self.textView setEditable:YES];
        
        [self.class drawBorderForView:self.nameField];
        [self.class drawBorderForView:self.textView];
    }
    else
    {
        [self.nameField setEnabled:NO];
        [self.textView setEditable:NO];
        
        [self.class removeBorderForView:self.nameField];
        [self.class removeBorderForView:self.textView];
        
        NSString *text = [self.textView text];
        NSString *name = [self.nameField text];
        
        if ([text length] > 0)
        {
            [self.note setText:text];
        }
        
        if ([name length] > 0)
        {
            [self.note setName:self.nameField.text];
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Class methods

+ (void)drawBorderForView:(UIView*)view
{
    view.layer.borderWidth = 1.0f;
    view.layer.borderColor = [UIColor.lightGrayColor CGColor];
    view.layer.cornerRadius = 5.0f;
}

+ (void)removeBorderForView:(UIView*)view
{
    view.layer.borderWidth = 0.0f;
    view.layer.borderColor = [UIColor.clearColor CGColor];
    view.layer.cornerRadius = 0.0f;
}

@end
