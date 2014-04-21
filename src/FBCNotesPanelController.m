//
//  FBCNotesController.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 12/03/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "FBCNotesPanelController.h"
#import "FBCNewNoteController.h"
#import "FBCExercise.h"
#import "FBCNoteCell.h"
#import "FBCNote.h"

#define kFBCNoteDetailSize CGSizeMake(600, 200)

@implementation FBCNotesPanelController

@synthesize exercise = _exercise;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *separatorColor = [UIColor colorWithRed:0.02352941176471 green:0.07450980392157 blue:0.24313725490196
                                              alpha:1.0];
    
    [self.tableView setSeparatorColor:separatorColor];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *notes = [self.exercise notes];
    
    return [notes count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FBCNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:kFBCExerciseNoteCell];
    NSInteger index = [indexPath row];
    FBCNote *note = [self noteAtIndex:index];
    UIColor *backgroundColor = [UIColor colorWithRed:0.84705882352941 green:0.96862745098039 blue:1.0 alpha:1.0];

    [cell setNote:note];
    [cell.nameField setText:note.name];
    [cell.textView setText:note.text];
    [cell.textView setTextContainerInset:UIEdgeInsetsZero];
    [cell setBackgroundColor:backgroundColor];
    
    return cell;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static const CGFloat textWidth = 263;
    static const CGFloat textViewTopMargin = 49;
    static const CGFloat textViewBottomMargin = 8;

    NSInteger index = [indexPath row];
    FBCNote *note = [self noteAtIndex:index];
    NSString *noteText = [note text];
    
    CGRect rect = [noteText boundingRectWithSize:CGSizeMake(textWidth - 10, 1024)
                                         options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                         context:nil];
    
    CGFloat result = rect.size.height + 2 + textViewBottomMargin + textViewTopMargin;
    
    return result;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIPopoverControllerDelegate methods

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self.tableView reloadData];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = [segue identifier];
    
    if ([identifier isEqualToString:kFBCNoteDetailPopoverSegue])
    {
        FBCNewNoteController *dst = [segue destinationViewController];

        [dst setExercise:self.exercise];
        
        UIStoryboardPopoverSegue *theSegue = (UIStoryboardPopoverSegue*)segue;
        UIPopoverController *popController = [theSegue popoverController];
        
        [dst setPopController:popController];
        [popController setPopoverContentSize:kFBCNoteDetailSize];
        [popController setDelegate:self];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI actions

- (IBAction)editButtonPressed:(UIButton *)sender
{
    [self enableEditing];
}

- (IBAction)doneButtonPressed:(UIButton *)sender
{
    [self disableEditing];
}

- (IBAction)deleteButtonPressed:(UIButton *)sender
{
    NSArray *selectedIndexPaths = [self.tableView indexPathsForSelectedRows];
    NSMutableArray *selectedNotes = [NSMutableArray arrayWithCapacity:selectedIndexPaths.count];
    
    [selectedIndexPaths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = obj;
        NSInteger index = [indexPath row];
        FBCNote *note = [self noteAtIndex:index];
        
        [selectedNotes addObject:note];
    }];
    
    [selectedNotes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        FBCNote *note = obj;
        
        [self.exercise removeNote:note];
    }];
    
    [self disableEditing];
    [self.tableView deleteRowsAtIndexPaths:selectedIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Helpers

- (FBCNote*)noteAtIndex:(NSInteger)index
{
    NSArray *notes = [self.exercise notes];
    NSInteger count = [notes count];
    
    if (index >= count)
    {
        return nil;
    }
    
    return [notes objectAtIndex:index];
}

- (void)enableEditing
{
    [self.tableView setEditing:YES animated:YES];
    
    [self.editButton setHidden:YES];
    [self.addButton setHidden:YES];
    [self.doneButton setHidden:NO];
    [self.deleteButton setHidden:NO];
}

- (void)disableEditing
{
    [self.tableView setEditing:NO animated:YES];
    
    [self.doneButton setHidden:YES];
    [self.deleteButton setHidden:YES];
    [self.editButton setHidden:NO];
    [self.addButton setHidden:NO];
}

@end
